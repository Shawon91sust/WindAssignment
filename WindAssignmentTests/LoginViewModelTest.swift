//
//  LoginViewModelTest.swift
//  WindAssignmentTests
//
//  Created by Shawon Rejaul on 5/3/23.
//

import XCTest
import Combine
@testable import WindAssignment

final class LoginViewModelTest: XCTestCase {
    
    private var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        cancellables = []
    }

    func test_username_shouldReturnFalse_whenNotValid() {
        let sut = LoginViewModel()
        //wi123, abc__123, a..b_c, a#bc, ab123
        let username1 = "wi123"
        XCTAssertFalse(sut.userNameValidation(username1))
        
        let username2 = "abc__123"
        XCTAssertFalse(sut.userNameValidation(username2))
        
        let username3 = "a..b_c"
        XCTAssertFalse(sut.userNameValidation(username3))
        
        let username4 = "a#bc"
        XCTAssertFalse(sut.userNameValidation(username4))
        
        let username5 = "ab123"
        XCTAssertFalse(sut.userNameValidation(username5))
    }
    
    func test_username_shouldReturnTrue_whenValid() {
        let sut = LoginViewModel()
        //win123, abc_123, a.b_c, a_b_c
        let username1 = "win123"
        XCTAssertTrue(sut.userNameValidation(username1))
        
        let username2 = "abc_123"
        XCTAssertTrue(sut.userNameValidation(username2))
        
        let username3 = "a.b_c"
        XCTAssertTrue(sut.userNameValidation(username3))
        
        let username4 = "a_b_c"
        XCTAssertTrue(sut.userNameValidation(username4))
        
        
    }
    
    func test_input_shouldReturnFalse_whenNotValid() {
        
        let ex = XCTestExpectation()
        
        let sut = LoginViewModel()
        
        sut.userName = "te1_"
        sut.pin = "1234"
        
        sut.isInputValid.sink { value in
            if(!value) {
                ex.fulfill()
            }
        }.store(in: &cancellables)
        
        wait(for: [ex], timeout: 10)
    }
    
    func test_input_shouldReturnTrue_whenValid() {
            let ex = XCTestExpectation()

            let sut = LoginViewModel()

            sut.userName = "test"
            sut.pin = "1234"

            sut.isInputValid.sink { value in
                if(value) {
                    ex.fulfill()
                }
            }.store(in: &cancellables)

            wait(for: [ex], timeout: 10)
    }
    
    func test_callLoginService_shouldCallSuccess() {
        
        let sut = MockLoginViewModel()
        sut.callSuccessLoginService()
        XCTAssertTrue(sut.loginSuccess)
    }
    
    func test_callLoginService_shouldCallFail() {
        
        let sut = MockLoginViewModel()
        sut.callFailLoginService()
        XCTAssertTrue(sut.loginFail)
    }
}

class MockLoginViewModel: LoginViewModel {
    
    var loginSuccess = false
    var loginFail = false
    var testService : MockLoginService
    var showCurrencyPickerCalled = false
    
    init(service: MockLoginService = MockLoginService()) {
        self.testService = service
    }

    func callSuccessLoginService() {
        loginSuccess = testService.performSuccessLoginTest()
    }
    
    func callFailLoginService() {
        loginFail = testService.performFailLoginTest()
    }
    
    
    
    
}


final class MockLoginService: LoginService {

    func performSuccessLoginTest() -> Bool {
        let jsonStr = """
        {
          "status": true,
          "messages": [
            "Request Seccess"
          ],
          "data": {
            "userInfo": {
              "Id": 365,
              "Email": "nadimh@wind.app",
              "UserName": "nadimh",
              "WalletAddress": "0x95d8efac952e42148a4faf091e5b2407a7834e77",
              "smartContactWallet": "0x4dda336dCFF6B88078909E9b156d36A91EA00087",
              "ProfileImage": "https://lh3.googleusercontent.com/a/AEdFTp4zOK4n_7WajLyS9qa8ppvAqMVvGeJMuGflMzwGfQ=s96-c"
            },
            "accountInfo": {
              "balance": 381.500956,
              "currency": "USDC"
            }
          }
        }
    """
        
        
        let data = jsonStr.data(using: .utf8)!
        let response = try! JSONDecoder().decode(LoginResponse.self, from: data)
        
        if(response.status) {
            return true
        } else {
            return false
        }
        
        
    }
    
    func performFailLoginTest() -> Bool {
        let jsonStr = """
        {
          "timestamp": "2023-02-13T05:12:56.884Z", "path": "/api/v1/login",
          "path": "/api/v1/login",
          "status": false,
          "statusCode": 400,
          "error": "Bad Request",
          "requestId": "f2990766-44000"
        }
    """
        
        
        let data = jsonStr.data(using: .utf8)!
        let response = try! JSONDecoder().decode(LoginResponse.self, from: data)
        
        if(!response.status) {
            return true
        } else {
            return false
        }
    }
}


