//
//  RoundedButton.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 3/3/23.
//

import UIKit


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
        UIView.animate(withDuration: 0.1) {
            if self.isSelect {
                self.setTitleColor(.white, for: .selected)
                self.tintColor = .white
                self.backgroundColor = UIColor("#6E50FF")
            } else {
                self.setTitleColor(.black, for: .normal)
                self.tintColor = .black
                self.backgroundColor = .white
            }
        }
        
        
        //self.layer.cornerRadius = 8.0
        //self.layer.masksToBounds = true
        
    }
    
    
    var isSelect: Bool = false {
        didSet {
            layoutSubviews()
        }
    }
    
    
    
    
    
}
