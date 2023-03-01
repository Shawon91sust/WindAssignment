//
//  UDService.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 2/3/23.
//

import Foundation
import UIKit



enum UDKeys: String {
    case isLogin = "Logged_In"
    case userID = "user_id"
}

class UDService {
        static let sharedInstance = UDService()
        private let ud = UserDefaults.standard
        private init() {}

    var isLogin: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UDKeys.isLogin.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UDKeys.isLogin.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    var userID: Int {
        get {
            return UserDefaults.standard.integer(forKey: UDKeys.userID.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UDKeys.userID.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}

extension UDService {
    func resetDefaults() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}
