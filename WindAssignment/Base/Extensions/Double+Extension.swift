//
//  Double+Extension.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 4/3/23.
//

import Foundation

extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}
