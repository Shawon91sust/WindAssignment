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
        .map { username, pin in
            print(username)
            print(pin)
            return (username.count > 2) }
        .eraseToAnyPublisher()
    
    
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
        
//        loginService.performLogin(params: loginParams) {[weak self] loginResponse in
//            self?.isLoading = false
//
//            guard let userdata = loginResponse.data else { return }
//
//            self?.loginResult.send(userdata)
//
//        } fail: { [weak self] error in
//            self?.isLoading = false
//            self?.loginResult.send(completion: .failure(error))
//        }
        
        loginService.performLoginDemo {[weak self] loginResponse in
            self?.isLoading = false
            
            guard let userdata = loginResponse.data else { return }
            
            self?.loginResult.send(userdata)
            
        } fail: { [weak self] error in
            self?.isLoading = false
            self?.loginResult.send(completion: .failure(error))
        }   
    }
    

    
}
