//
//  PinField.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 2/3/23.
//

import UIKit
import Reusable
import IQKeyboardManagerSwift


class PinField: UIView, NibOwnerLoadable {
    
    @IBOutlet weak var firstField: UITextField!
    @IBOutlet weak var secondField: UITextField!
    @IBOutlet weak var thirdField: UITextField!
    @IBOutlet weak var fourthField: UITextField!
    
    @IBOutlet weak var firstBar: UIView!
    @IBOutlet weak var secondBar: UIView!
    @IBOutlet weak var thirdBar: UIView!
    @IBOutlet weak var fourthBar: UIView!
    
    @IBOutlet weak var stackView: UIStackView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNibContent()
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadNibContent()
    }
    
    func setup() {
        
        firstField.becomeFirstResponder()
        firstBar.backgroundColor = .black
        
        firstField.delegate = self
        secondField.delegate = self
        thirdField.delegate = self
        fourthField.delegate = self
        
        firstField.keyboardType = .numberPad
        secondField.keyboardType = .numberPad
        thirdField.keyboardType = .numberPad
        fourthField.keyboardType = .numberPad
        
        firstField.tintColor = .black
        secondField.tintColor = .black
        thirdField.tintColor = .black
        fourthField.tintColor = .black
        
    }
    
    
        
}

extension PinField : UITextFieldDelegate {
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textCount = textField.text?.count else { return false }
        
        if(textCount < 1 && string.count > 0) {
            switch textField {
            case firstField:
                firstBar.backgroundColor = .black
                secondBar.backgroundColor = .black
                secondField.becomeFirstResponder()
            case secondField:
                secondBar.backgroundColor = .black
                thirdBar.backgroundColor = .black
                thirdField.becomeFirstResponder()
            case thirdField:
                thirdBar.backgroundColor = .black
                fourthBar.backgroundColor = .black
                fourthField.becomeFirstResponder()
            case fourthField:
                fourthBar.backgroundColor = .black
                fourthField.resignFirstResponder()
            default:
                Logger.log("Default")
            }
            
            textField.text = string
            return false
            
        } else if (textCount >= 1 && string.count == 0) {
            switch textField {
            
            case secondField:
                secondBar.backgroundColor = .lightGray
                firstField.becomeFirstResponder()
            case thirdField:
                thirdBar.backgroundColor = .lightGray
                secondField.becomeFirstResponder()
            case fourthField:
                fourthBar.backgroundColor = .lightGray
                thirdField.becomeFirstResponder()
            case firstField:
                firstBar.backgroundColor = .lightGray
                firstField.resignFirstResponder()
            default:
                Logger.log("Default")
            }
            
            textField.text = ""
            return false
        } else if (textCount >= 1 ) {
            textField.text = string
            return false
        }
        
        return true
    }
}
