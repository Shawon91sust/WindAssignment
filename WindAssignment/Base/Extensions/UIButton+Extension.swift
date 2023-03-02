//
//  UIButton+Extension.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 3/3/23.
//

import UIKit


extension UIButton {
    func addShadow(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 1.0
        layer.shadowColor = UIColor("000000", alpha: 0.1).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
    }
}
