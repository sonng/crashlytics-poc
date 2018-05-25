//
// Created by Son Nguyen on 25/5/18.
// Copyright (c) 2018 Son Nguyen. All rights reserved.
//

import Foundation

public enum LoggingLevel: Int {
    case info
    case debug
    case warning
    case error
    case exception
}

public protocol LoggingServiceProtocol: LoggingToolProtocol {
    func addLoggingTool(tool: LoggingToolProtocol)
}

public protocol LoggingToolProtocol {
    func log(_ level: LoggingLevel, message: String)
}

public extension LoggingToolProtocol {
    public func logException(message: String) {
        log(.exception, message: message)
    }

    public func logError(message: String) {
        log(.error, message: message)
    }

    public func logWarning(message: String) {
        log(.warning, message: message)
    }

    public func logDebug(message: String) {
        log(.debug, message: message)
    }

    public func logInfo(message: String) {
        log(.info, message: message)
    }
}
