# Logger

```swift
import Foundation
import os

func message<T>(_ message: T,
                level: Logger.Level = Logger.level,
                file: String = #file, function: String = #function, line: Int = #line) -> String? {
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
```

### Usage

```swift
//
//  AppDelegate.swift
//  ***
//
//  Created by *** on 2020/02/04.
//  Copyright © 2020 ***. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        log(message("App did Launch.", level: .verbose))

        return true
    }

}
```
output
```
2020-02-13 16:15:34.269027+0900 ***[5291:1333819] 
[file:AppDelegate.swift]:[line:18]
[thread:<NSThread: 0x282e26f00>{number = 1, name = main}]
App did Launch.
===========================================
```
