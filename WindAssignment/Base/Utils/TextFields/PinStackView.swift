//
//  PinStackView.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 4/3/23.
//

import UIKit
import Reusable

protocol OTPDelegate: AnyObject {
    //always triggers when the OTP field is valid
    func didChangeValidity(isValid: Bool)
}

class PinStackView: UIView, NibOwnerLoadable {
    
    @IBOutlet weak var firstField: OTPTextField!
    @IBOutlet weak var secondField: OTPTextField!
    @IBOutlet weak var thirdField: OTPTextField!
    @IBOutlet weak var fourthField: OTPTextField!
    
    @IBOutlet weak var firstBar: UIView!
    @IBOutlet weak var secondBar: UIView!
    @IBOutlet weak var thirdBar: UIView!
    @IBOutlet weak var fourthBar: UIView!
    
    var textFieldsCollection: [OTPTextField] = []
    var barCollection: [UIView] = []
    weak var delegate: OTPDelegate?
    var remainingStrStack: [String] = []
    
    @IBOutlet weak var stackView: UIStackView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNibContent()
        addFields()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.loadNibContent()
    }
    
    private final func addFields() {
        
        firstField.delegate = self
        firstField.previousTextField = nil
        firstField.nextTextField = secondField
        
        secondField.delegate = self
        secondField.previousTextField = firstField
        secondField.nextTextField = thirdField
        
        thirdField.delegate = self
        thirdField.previousTextField = secondField
        thirdField.nextTextField = fourthField
        
        fourthField.delegate = self
        fourthField.previousTextField = thirdField
        fourthField.nextTextField = nil
        
        textFieldsCollection.append(contentsOf: [firstField, secondField, thirdField, fourthField])
        barCollection.append(contentsOf: [firstBar, secondBar, thirdBar, fourthBar])
        
        for tf in textFieldsCollection {
            tf.isEnabled = false
        }
        
        
    }
    
    func startPinInput() {
        for tf in textFieldsCollection {
            tf.isEnabled = true
        }
        barCollection[0].backgroundColor = .black
    }
    
    func stopPinInput() {
        //textFieldsCollection[0].becomeFirstResponder()
        
        for v in barCollection {
            v.backgroundColor = .lightGray
        }
        
        for tf in textFieldsCollection {
            tf.text = ""
            tf.isEnabled = false
        }
        
        
        
    }
    
//    func setup() {
//
//        firstField.delegate = self
//        secondField.delegate = self
//        thirdField.delegate = self
//        fourthField.delegate = self
//
//        firstField.keyboardType = .numberPad
//        secondField.keyboardType = .numberPad
//        thirdField.keyboardType = .numberPad
//        fourthField.keyboardType = .numberPad
//
//        firstField.tintColor = .black
//        secondField.tintColor = .black
//        thirdField.tintColor = .black
//        fourthField.tintColor = .black
//
//    }
    
    private final func checkForValidity(){
        for fields in textFieldsCollection{
            if (fields.text?.trimmingCharacters(in: CharacterSet.whitespaces) == ""){
                delegate?.didChangeValidity(isValid: false)
                return
            }
        }
        delegate?.didChangeValidity(isValid: true)
    }
    
    //gives the OTP text
    final func getOTP() -> String {
        var OTP = ""
        for textField in textFieldsCollection{
            OTP += textField.text ?? ""
        }
        return OTP
    }
    
    //autofill textfield starting from first
    private final func autoFillTextField(with string: String) {
        
        remainingStrStack = string.reversed().compactMap{String($0)}
        for textField in textFieldsCollection {
            if let charToAdd = remainingStrStack.popLast() {
                textField.text = String(charToAdd)
            } else {
                break
            }
        }
        checkForValidity()
        remainingStrStack = []
    }
    
    
        
}

//MARK: - TextField Handling
extension PinStackView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        barCollection[textField.tag].backgroundColor = .black
        
    }
    
    
        
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if(text == "") {
            barCollection[textField.tag].backgroundColor = .lightGray
        } else {
            barCollection[textField.tag].backgroundColor = .black
        }
        
        checkForValidity()
    }
    
    //switches between OTPTextfields
    func textField(_ textField: UITextField, shouldChangeCharactersIn range:NSRange,
                   replacementString string: String) -> Bool {
        guard let textField = textField as? OTPTextField else { return true }
        if string.count > 1 {
            textField.resignFirstResponder()
            autoFillTextField(with: string)
            return false
        } else {
            if (range.length == 0 && string == "") {
                return false
            } else if (range.length == 0){
                if textField.nextTextField == nil {
                    textField.text? = string
                    textField.resignFirstResponder()
                }else{
                    textField.text? = string
                    textField.nextTextField?.becomeFirstResponder()
                }
                return false
            }
            return true
        }
    }
    
}



