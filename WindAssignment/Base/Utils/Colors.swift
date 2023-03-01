//
//  Colors.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 2/3/23.
//

import UIKit



extension UIColor {
    
    
    convenience init(_ hex:String, alpha: CGFloat = 1.0) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") { cString.removeFirst() }
        
        if cString.count != 6 {
            self.init("ff0000")
            return
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                      alpha: alpha)
 
    }
    
    
    @nonobjc class var lightText: UIColor {
        return UIColor(red: 104.0/255.0, green: 104.0/255.0, blue: 104.0/255.0, alpha: 1)
    }
    
    @nonobjc class var blackText: UIColor {
        return UIColor(red: 49.0/255.0, green: 49.0/255.0, blue: 49.0/255.0, alpha: 1)
    }
    
    
    
    @nonobjc class var grayBG: UIColor {
        return UIColor(red: 0.46, green: 0.46, blue: 0.46, alpha: 1.0)
    }
    
    @nonobjc class var buttonGrey: UIColor {
        return UIColor(red: 0.0/255.0, green: 106.0/255.0, blue: 178.0/255.0, alpha: 1)
    }
    
    @nonobjc class var buttonGreyBg: UIColor {
        return UIColor(red: 244.0/255.0, green: 244.0/255.0, blue: 244.0/255.0, alpha: 1)
    }
    
    @nonobjc class var buttonGreenBG1: UIColor {
        return UIColor(red: 0.0/255.0, green: 170.0/255.0, blue: 161.0/255.0, alpha: 1)
    }
    
    @nonobjc class var buttonWhiteBG: UIColor {
        return UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1)
    }
    
    @nonobjc class var buttonGreenBG2: UIColor {
        return UIColor(red: 81.0/255.0, green: 144.0/255.0, blue: 108.0/255.0, alpha: 1)
    }
    
    @nonobjc class var baseGreenButtonBG: UIColor {
        return UIColor(red: 0.0/255.0, green: 125.0/255.0, blue: 117.0/255.0, alpha: 1)
    }
    
    @nonobjc class var viewBackGround : UIColor {
        return UIColor(red: 242.0/255.0, green: 242.0/255.0, blue: 247.0/255.0, alpha: 1)
    }
    
    @nonobjc class var textFieldPlaceholderColor : UIColor {
        return UIColor(red: 159.0/255.0, green: 165.0/255.0, blue: 192.0/255.0, alpha: 1)
    }
    
    
   
    
    
    

}
