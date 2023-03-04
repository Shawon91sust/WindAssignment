//
//  OTPTextField.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 4/3/23.
//

import Foundation
import UIKit

class OTPTextField: UITextField {
    
    weak var previousTextField: OTPTextField?
    weak var nextTextField: OTPTextField?
    
    override public func deleteBackward(){
        text = ""
        previousTextField?.becomeFirstResponder()
    }
    
}
