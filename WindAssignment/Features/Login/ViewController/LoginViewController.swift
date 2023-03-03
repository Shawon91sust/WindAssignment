//
//  LoginViewController.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 1/3/23.
//

import Combine
import UIKit
import Reusable

class LoginViewController: BaseViewController, StoryboardSceneBased {
    
    static let sceneStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    private var loginViewModel = LoginViewModel()
    private var bindings = Set<AnyCancellable>()
    
    @IBOutlet weak var userNameField: LeftIconTextField!
    @IBOutlet weak var pinField: PinField!
    @IBOutlet weak var loginButton: BaseButton!
    
    var isLoading: Bool = false {
        didSet { isLoading ? showLoader() : hideLoader() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setUpBindings()
    }
    
    
    
    func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        userNameField.type = .userNameField
        loginButton.type = .cont
        userNameField.textField.becomeFirstResponder()
        //loginButton.isValid = true
    }
    
    private func setUpBindings() {
        func bindViewToViewModel() {
            userNameField.textField.textPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.userName, on: loginViewModel)
                .store(in: &bindings)
            
            pinField.fourthField.textPublisher
                .receive(on: RunLoop.main)
                .assign(to: \.pin, on: loginViewModel)
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {
            loginViewModel.isInputValid
                .receive(on: RunLoop.main)
                .assign(to: \.isValid, on: self.loginButton)
                .store(in: &bindings)
            
            loginViewModel.$isLoading
                .assign(to: \.isLoading, on: self)
                .store(in: &bindings)
            
            loginViewModel.loginResult
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        print(error.localizedDescription)
                        return
                    case .finished:
                        return
                    }
                } receiveValue: { [weak self] userData in
                    self?.navigateToSendFund(userData)
                }
                .store(in: &bindings)
            
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        
        loginViewModel.callLoginService()
    }
    
    func navigateToSendFund(_ data : UserData) {
        let storyboard = Storyboards.sharedInstance.retrieveStoryBoard(BoardName.Main)
        let vc = storyboard.instantiateViewController(identifier: SendFundViewController.sceneIdentifier) { coder in
            SendFundViewController(coder: coder, data: data)
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
        self.view.endEditing(true)
    }
    
}

