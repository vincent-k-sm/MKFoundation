//
//  File.swift
//


import Foundation
class SystemUtils {
    static let shared = SystemUtils()
    
    /// Toggles debug print() statements
    var debugEnabled = false
    
    init() { }
}


extension SystemUtils {
    /// Prints debug messages to the console if debugEnabled is set to true.
    ///
    /// - Parameter message: The status to print to the console.
    ///
    func print(_ message: Any, _ target: Any, file: String = #file, line: Int = #line, function: String = #function) {

        if debugEnabled == true {
            var filename: NSString = file as NSString
            filename = filename.lastPathComponent as NSString

            let className: String = String.init(describing: target).components(separatedBy: ".").last?.components(separatedBy: ":").first ?? ""
            let prefix: String = "[\(Constants.frameworkName)]\n"
            var logString: String = "|Class: \(className)\n|File: \(filename)\n|Line: \(line)\n|Function: \(function)\n|Desc: "
            if let msg = message as? String {
                logString += msg
            }
            else {
                logString += "\n \(message)"
            }
            
            #if DEBUG
            Swift.print("------------------------------------------------------------------------------")
            Swift.print(prefix + logString)
            Swift.print("------------------------------------------------------------------------------")
            #endif
//            Swift.print("[\(Constants.frameworkName) (\(line))]: \(message)")
        }
    }

}

extension SystemUtils {
    struct Constants {
        static let frameworkName = "MK Foundation"
    }

}
