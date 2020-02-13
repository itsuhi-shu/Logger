import Foundation
import os

func message<T>(_ message: T,
                level: Logger.Level = Logger.level,
                file: String = #file, function: String = #function, line: Int = #line) -> String? {
    guard Logger.Level != .release else { return nil }
    switch level {
    case .verbose:
        let fileName = (file as NSString).lastPathComponent
        return """

        [file:\(fileName)]:[line:\(line)]
        [thread:\(Thread.current)]
        \(message)
        ===========================================
        """
    case .debug:
        return "\(message)"
    case .release:
        return nil
    }
}

func log(_ message: @autoclosure () -> String?) {
    if let message = message() {
        os_log("%@", message)
    }
}

struct Logger {
    enum Level {
        case release
        case debug
        case verbose
    }
    
    static var level: Level = .release
}
