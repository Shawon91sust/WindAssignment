//
//  BaseButton.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 2/3/23.
//

import UIKit

enum BaseButtonType {
    case cont
}


class BaseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.font = AppFont.book.size(18.0)
        self.titleLabel?.text = "Continue"
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.white, for: .disabled)
        self.tintColor = .white
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = true
    }
    
    var isValid: Bool {
        get { isEnabled && backgroundColor == .baseButtonBG }
        set {
            backgroundColor = newValue ? .baseButtonBG : .baseButtonInvalidBG
            isEnabled = newValue
            layoutSubviews()
        }
    }
    
    
    var type: BaseButtonType? {
        didSet {
            guard let type = type else {
                return
            }

            switch type {
            case .cont:
                self.titleLabel?.text = "Continue"
                layoutSubviews()
            }
        }
    }
}
