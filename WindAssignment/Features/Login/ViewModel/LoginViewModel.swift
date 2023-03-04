//
//  LoginViewModel.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 3/3/23.
//

import Foundation
import Combine
import UIKit


class LoginViewModel : ObservableObject {
   
    var loginService : LoginService
    
    @Published var userName = ""
    @Published var pin = ""
    @Published var isLoading = false
    let loginResult = PassthroughSubject<UserData, Error>()
    
    private(set) lazy var isInputValid = Publishers.CombineLatest($userName, $pin)
        .map { [weak self] username, pin in
            guard let valid = self?.userNameValidation(username) else { return false }
            return (valid && pin.count == 4) }
        .eraseToAnyPublisher()
    
    var isUserNameValid : AnyPublisher<Bool, Never> {
        $userName
        .map { [weak self] name in
            print(name)
            
            guard let valid = self?.userNameValidation(name) else { return false }
            
            return valid }
        .eraseToAnyPublisher()
    }
    
    
    init(service: LoginService = LoginService()) {
        self.loginService = service
    }

    func callLoginService() {
        isLoading = true
        
        print(userName)
        print(pin)
        
        let loginParams = ["user" : userName,
                           "pin" : pin
                          ]
        
        loginService.performLoginDemo {[weak self] loginResponse in
            self?.isLoading = false
            
            guard let userdata = loginResponse.data else { return }
            
            self?.loginResult.send(userdata)
            
        } fail: { [weak self] error in
            self?.isLoading = false
            self?.loginResult.send(completion: .failure(error))
        }   
    }
    
    func userNameValidation(_ text : String) -> Bool {
        
        let validation = NSPredicate(format:"SELF MATCHES %@", "^(?!.*[.]{2})(?!.*[_]{2})(?=.*[a-z].*[a-z].*[a-z])[a-z0-9_.]{3,32}$")
        
        return validation.evaluate(with: text)
    }
    

    
}
