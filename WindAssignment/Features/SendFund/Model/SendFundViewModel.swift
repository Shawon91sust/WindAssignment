//
//  SendFundViewModel.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 4/3/23.
//

import Foundation
import Combine
import UIKit


class SendFundViewModel : ObservableObject {
   
    

    @Published var inputValue = ""
    @Published var maxBalance = 0.0
    @Published var isLoading = false
    
    //@Published var inputValid = false
    //@Published var inSufficient = false
    //@Published var maxSelect = false
    
    private(set) lazy var isInputValid = Publishers.CombineLatest($inputValue, $maxBalance)
        .map { input, max in

            guard let value = Double(input) else { return false }
            return (max >= value) }
        .eraseToAnyPublisher()
    
    private(set) lazy var remainingBalance : AnyPublisher<Double, Never> = Publishers.CombineLatest($inputValue, $maxBalance)
        .map { input, max in

            guard let value = Double(input) else { return max }
            return (max - value) }
        .eraseToAnyPublisher()
    
    private(set) lazy var maxSelected : AnyPublisher<Bool, Never> = Publishers.CombineLatest($inputValue, $maxBalance)
        .map { input, max in
            guard let value = Double(input) else { return false}
            return (max == value) }
        .eraseToAnyPublisher()
    
    private(set) lazy var sufficientBalance = Publishers.CombineLatest($inputValue, $maxBalance)
        .map { input, max in

            guard let value = Double(input) else { return true }
            return (value <= max ) }
        .eraseToAnyPublisher()
    
    
    init() {}
    
//    func remainingFund() -> AnyPublisher<Double, Never> {
//        return Publishers.CombineLatest($inputValue, $maxBalance)
//            .map { input, max  in
//                guard let value = Double(input) else { return max}
//                return (max - value).roundToDecimal(5)
//            }
//            .eraseToAnyPublisher()
//    }  
}
