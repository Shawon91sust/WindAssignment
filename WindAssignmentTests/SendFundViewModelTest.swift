//
//  SendFundViewModelTest.swift
//  WindAssignmentTests
//
//  Created by Shawon Rejaul on 5/3/23.
//

import XCTest
import Combine
@testable import WindAssignment

final class SendFundViewModelTest: XCTestCase {

    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }

    func test_inputValid_shouldReturnFalse_whenNotValid() {
        
        let ex = XCTestExpectation()
        
        let sut = SendFundViewModel()
        
        sut.maxBalance = 10.5
        sut.inputValue = "11.7"
        
        sut.isInputValid.sink { value in
            if(!value) {
                ex.fulfill()
            }
        }.store(in: &cancellables)
        
        wait(for: [ex], timeout: 10)
    }
    
    func test_inputValid_shouldReturnTrue_whenValid() {
        let ex = XCTestExpectation()
        
        let sut = SendFundViewModel()
        
        sut.maxBalance = 10.5
        sut.inputValue = "5.99"
        
        sut.isInputValid.sink { value in
            if(value) {
                ex.fulfill()
            }
        }.store(in: &cancellables)
        
        wait(for: [ex], timeout: 10)
    }
    
    func test_remainingBalance_shouldReturnValueEqualTo_maxBalanceMinusInput() {
        
        let sut = SendFundViewModel()
        
        sut.maxBalance = 10.5
        sut.inputValue = "5.99"
        
        let input = 5.99
        let remaining = sut.maxBalance - input
        
        sut.remainingBalance.sink { value in
            
            XCTAssertEqual(value, remaining)

        }.store(in: &cancellables)
        
    }
    
    func test_maxSelected_shouldSetMaxBalance_whenPressedMaxButton() {
        
        let sut = SendFundViewModel()
        
        sut.maxBalance = 10.5
        sut.inputValue = "10.5"
        
        sut.maxSelected.sink { value in
            
            XCTAssertTrue(value)

        }.store(in: &cancellables)
        
    }
    
    func test_sufficientBalance_shouldSetFalse_whenInputGreaterThanMaxBalance() {
        
        let sut = SendFundViewModel()
        
        sut.maxBalance = 10.5
        sut.inputValue = "15.5"
        
        sut.sufficientBalance.sink { value in
            
            XCTAssertFalse(value)

        }.store(in: &cancellables)
        
    }

}
