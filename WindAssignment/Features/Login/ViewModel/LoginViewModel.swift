//
//  LoginViewModel.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 3/3/23.
//

import Foundation
import Combine
import UIKit


enum ResponseState {
    case unknown
    case success(_ data : UserData)
    case failure(Error)
}

class LoginViewModel : ObservableObject {
   
    var loginService : LoginService
    
    @Published var userName = ""
    @Published var pin = ""
    @Published var isLoading = false
    @Published private(set) var response: ResponseState = .unknown
    //@Published var userData : UserData?
    //@Published var error : Error?
    //let loginResult : CurrentValueSubject<UserData, Error>?
    
    private(set) lazy var isInputValid = Publishers.CombineLatest($userName, $pin)
        .map { [weak self] username, pin in
            guard let valid = self?.userNameValidation(username) else { return false }
            return (valid && pin.count == 4) }
        .eraseToAnyPublisher()
    
    var isUserNameValid : AnyPublisher<Bool, Never> {
        $userName
        .map { [weak self] name in
            guard let valid = self?.userNameValidation(name) else { return false }
            return valid }
        .eraseToAnyPublisher()
    }
    
    
    init(service: LoginService = LoginService()) {
        self.loginService = service
    }

    func callLoginService() {
        isLoading = true
        let loginParams = ["user" : userName,
                           "pin" : pin
                          ]
        
        print(loginParams)
        
        loginService.performLogin(params : loginParams) {[weak self] loginResponse in
            self?.isLoading = false
            
            guard let userdata = loginResponse.data else { return }
            self?.response = .success(userdata)
            
        } fail: { [weak self] error in
            self?.isLoading = false
            self?.response = .failure(error)
        }   
    }
    
    
    func userNameValidation(_ text : String) -> Bool {
        
        let validation = NSPredicate(format:"SELF MATCHES %@", "^(?!.*[.]{2})(?!.*[_]{2})(?=.*[a-z].*[a-z].*[a-z])[a-z0-9_.]{3,32}$")
        
        return validation.evaluate(with: text)
    }
    

    
}
