//
//  LeftIconTextField.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 2/3/23.
//

import UIKit
import Reusable
import IQKeyboardManagerSwift


enum LeftIconTextFieldType {
    case userNameField
    case balanceField
}

class LeftIconTextField: UIView, NibOwnerLoadable {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var leftLabel: UILabel!
    
    
    var type: LeftIconTextFieldType? {
        didSet {
            guard let type = type else {
                return
            }
            
            switch type {
            case .userNameField:
                self.textField.setLeftPaddingPoints(6.0)
                self.leftLabel.text = "@"
                self.leftLabel.font = AppFont.book.size(18.0)
            case .balanceField:
                Logger.log("Balance Field")
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadNibContent()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadNibContent()
    }
    
}
