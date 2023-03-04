//
//  UIViewController+Extension.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 4/3/23.
//

import UIKit

extension UIViewController {
    func showLoader() {
        Loader.shared.show()
    }

    func hideLoader() {
        Loader.shared.hide()
    }
}
