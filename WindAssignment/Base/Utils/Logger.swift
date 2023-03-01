//
//  Logger.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 2/3/23.
//

import Foundation

class Logger {
    static func log(_ object: Any?) {
        #if DEBUG
        print(object ?? "")
        #endif
    }
    
    private init() { }
}
