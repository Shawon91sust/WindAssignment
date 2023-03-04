//
//  LoginViewController.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 1/3/23.
//

import Combine
import UIKit
import Reusable

class LoginViewController: UIViewController, StoryboardSceneBased {
    
    static let sceneStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    private var loginViewModel = LoginViewModel()
    private var bindings = Set<AnyCancellable>()
    
    @IBOutlet weak var userNameField: LeftIconTextField!
    @IBOutlet weak var loginButton: BaseButton!
    @IBOutlet weak var pinStackView: PinStackView!
    
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
        userNameField.textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        userNameField.textField.delegate = self
        pinStackView.delegate = self
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        textField.text = text.lowercased()
        
        print(userNameValidation(text.lowercased()))
    }
    
    func userNameValidation(_ text : String) -> Bool {
        
        //"^(?=.*[a-z].*[a-z].*[a-z]){3,32}[a-z0-9_.]{3,32}$"
        //"^(?!.*[.]{2})(?!.*[_]{2})[a-z0-9_.]{3,32}$"
       
        let validation = NSPredicate(format:"SELF MATCHES %@", "^(?!.*[.]{2})(?!.*[_]{2})(?=.*[a-z].*[a-z].*[a-z])[a-z0-9_.]{3,32}$")
        
        return validation.evaluate(with: text)
        
    }
    
    private func setUpBindings() {
        func bindViewToViewModel() {
            userNameField.textField.textPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.userName, on: loginViewModel)
                .store(in: &bindings)
        }
        
        func bindViewModelToView() {
            loginViewModel.isInputValid
                .receive(on: RunLoop.main)
                .assign(to: \.isValid, on: self.loginButton)
                .store(in: &bindings)
            
            loginViewModel.isUserNameValid
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] value in
                    if(value) {
                        self?.pinStackView.startPinInput()
                    }
                })
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


extension LoginViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let preText = textField.text as NSString?,
              preText.replacingCharacters(in: range, with: string).count <= 32 else {
            return false
        }
        
        return true
    }
}

extension LoginViewController: OTPDelegate {
    
    func didChangeValidity(isValid: Bool) {
        
        loginViewModel.pin = pinStackView.getOTP()
        print(pinStackView.getOTP())
    }
    
}

