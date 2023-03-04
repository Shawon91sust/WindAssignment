//
//  UILabel+Extension.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 4/3/23.
//

import UIKit

extension UILabel {
    
    func addBottomBorder(_ color: UIColor, _ height: CGFloat) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - height, width: self.frame.size.width, height: height)
        bottomLine.backgroundColor = color.cgColor
        layer.addSublayer(bottomLine)
    }
    
    func addGradient() {
        let gradient = UIImage.gradientImage(bounds: self.bounds, colors: [ UIColor("6E50FF"), UIColor("FF50BA")])
        self.textColor = UIColor(patternImage: gradient)
    }
    
}

extension CALayer {
    func addWaghaBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let border = CALayer()
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 1)
            break
        case UIRectEdge.bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1)
            break
        case UIRectEdge.left:
            border.frame = CGRect(x: 0, y: 0, width: 1, height: self.frame.height)
            break
        case UIRectEdge.right:
            border.frame = CGRect(x: self.frame.width - 1, y: 0, width: 1, height: self.frame.height)
            break
        default:
            break
        }
        border.backgroundColor = color.cgColor;
        self.addSublayer(border)
    }
}
