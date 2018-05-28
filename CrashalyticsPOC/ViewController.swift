//
//  ViewController.swift
//  CrashalyticsPOC
//
//  Created by Son Nguyen on 25/5/18.
//  Copyright © 2018 Son Nguyen. All rights reserved.
//

import UIKit
import Crashlytics
import RxSwift
import RxCocoa

enum CustomAppError: LocalizedError {
    case oneTypeOfError
    case anotherTypeOfError
    
    /// A localized message describing what error occurred.
    public var errorDescription: String? {
        switch self {
        case .oneTypeOfError:
            return "This is an error string for one Type of error"
        case .anotherTypeOfError:
            return "This is another type of error"
        }
    }
    
    /// A localized message describing the reason for the failure.
    public var failureReason: String? {
        switch self {
        case .oneTypeOfError:
            return "Failure reason for one Type of error"
        case .anotherTypeOfError:
            return "Another tyype of error failture reason"
        }
    }
    
    /// A localized message describing how one might recover from the failure.
    public var recoverySuggestion: String? {
        switch self {
        case .oneTypeOfError:
            return "The recovery path for one type of error"
        case .anotherTypeOfError:
            return "This is another type of error recovery"
        }
    }
    
    /// A localized message providing "help" text if the user requests help.
    public var helpAnchor: String? {
        switch self {
        case .oneTypeOfError:
            return "This is a help anchor for one type of error"
        case .anotherTypeOfError:
            return "Help anchor for another tyoe of error"
        }
    }
}

class ViewController: UIViewController {

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical

        stackView.addArrangedSubview(createButton(title: "Create Product", action: { CLSLogv("Create Button Pressed", getVaList([])) }))
        stackView.addArrangedSubview(createButton(title: "View Create Product Screen", action: { CLSLogv("Entered Create Product", getVaList([])) }))
        stackView.addArrangedSubview(createButton(title: "Pressed on name", action: { Crashlytics.sharedInstance().logEvent("press_button") }))
        stackView.addArrangedSubview(createButton(title: "Exception Logging", action: { Crashlytics.sharedInstance().recordError(CustomAppError.oneTypeOfError, withAdditionalUserInfo: ["UserName":"Test123", "ErrorType": "\(CustomAppError.oneTypeOfError)"])}))
        stackView.addArrangedSubview(createButton(title: "Exception Logging 2", action: { Crashlytics.sharedInstance().recordError(CustomAppError.anotherTypeOfError, withAdditionalUserInfo: ["Some more MEta":1])}))
        stackView.addArrangedSubview(createButton(title: "Crash", action: { Crashlytics.sharedInstance().crash() } ))

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func createButton(title: String, action: @escaping () -> ()) -> UIButton {
        let button = UIButton(type: .system)

        button.setTitle(title, for: .normal)
        button.rx.tap.subscribe(onNext: action).disposed(by: disposeBag)

        return button
    }
}

