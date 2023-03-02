//
//  AppProperties.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 2/3/23.
//

import UIKit
import IQKeyboardManagerSwift

final class AppProperties {
    
    static func setup() {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 30
        // IQKeyboardManager.shared.disabledDistanceHandlingClasses = [LoginViewController.self, SendFundViewController.self]
    }
    
    
}
