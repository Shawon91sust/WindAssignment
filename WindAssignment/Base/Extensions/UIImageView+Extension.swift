//
//  UIImageView+Extension.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 2/3/23.
//

import UIKit

extension UIImageView {
    func rounded() {
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.masksToBounds = true
    }
}
