//
//  Logger.swift
//  WeatherApp
//
//  Created by Huy Vo on 11/12/17.
//  Copyright © 2017 Huy Vo. All rights reserved.
//

import Foundation


class Logger{
    
    // 1. The date formatter
    static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS" // Use your own
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    func log(_ clazz: String, description: String){
        print( )
    }
    
    fileprivate class func sourceFileName(_ filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
    
    class func log(_ message: String, // 1.
        event: LogEvent, // 2.
        fileName: String = #file, // 3.
        line: Int = #line, // 4.
        column: Int = #column,// 5.
        funcName: String = #function)  // 6.
    {
        print("\(Date().toString())\(event.rawValue)[\(sourceFileName(fileName))]:\(line) \(column) \(funcName) -> \(message)")
    
    }
}

// 2. The Date to String extension
extension Date {
    func toString() -> String {
        return Logger.dateFormatter.string(from: self as Date)
    }
}

enum LogEvent: String {
    case e = "[‼️]" // error
    case i = "[ℹ️]" // info
    case d = "[💬]" // debug
    case v = "[🔬]" // verbose
    case w = "[⚠️]" // warning
    case s = "[🔥]" // severe
}
