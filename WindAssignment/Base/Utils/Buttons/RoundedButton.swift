//
//  RoundedButton.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 3/3/23.
//

import UIKit

enum RoundedButtonType {
    case max
    case addFund
}

class RoundedButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.font = AppFont.book.size(15.0)
        self.addShadow(cornerRadius: 8.0)
        
        guard let type = type else {
            return
        }

        
        
        switch type {
        case .max:
            self.titleLabel?.text = "Max"
            UIView.animate(withDuration: 0.1) {
                if self.isSelect {
                    self.setTitleColor(.white, for: .normal)
                    self.tintColor = .white
                    self.backgroundColor = UIColor("#6E50FF")
                } else {
                    self.setTitleColor(.black, for: .normal)
                    self.tintColor = .black
                    self.backgroundColor = .white
                }
            }
        case .addFund:
            self.titleLabel?.text = "Add fund"
            self.setTitleColor(UIColor("#6E50FF"), for: .normal)
            self.tintColor = UIColor("#6E50FF")
            self.backgroundColor = .white
        }
        
        
        
        
        //self.layer.cornerRadius = 8.0
        //self.layer.masksToBounds = true
        
    }
    
    
    var isSelect: Bool = false {
        didSet {
            layoutSubviews()
        }
    }
    
    var type: RoundedButtonType? {
        didSet {
            layoutSubviews()
        }
    }
    
    
    
    
    
}
