//
//  Debug.swift
//  Horoscope
//
//  Created by Karan Khullar on 05/08/19.
//  Copyright © 2019 ChicMic. All rights reserved.

import UIKit

// Logger for debug

final class Debug {

    static var isEnabled = false

    static func log(_ msg: @autoclosure () -> String = "", _ file: @autoclosure () -> String = #file, _ line: @autoclosure () -> Int = #line, _ function: @autoclosure () -> String = #function) {
        if isEnabled {
            let fileName = file().components(separatedBy: "/").last ?? ""
            print("[Debug] [\(fileName):\(line())]🍀🍀🍀: \(function()) \(msg())")
        }
    }
}
