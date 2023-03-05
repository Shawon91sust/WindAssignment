//
//  LoginViewController.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 1/3/23.
//

import Combine
import UIKit
import Reusable
import Toast_Swift




class LoginViewController: UIViewController, StoryboardSceneBased {
    
    static let sceneStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    private var loginViewModel = LoginViewModel()
    private var bindings = Set<AnyCancellable>()
    
    @IBOutlet weak var userNameField: LeftIconTextField!
    @IBOutlet weak var loginButton: BaseButton!
    @IBOutlet weak var pinStackView: PinStackView!
    
    let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_."

    
    
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
                .debounce(for: 0.5, scheduler: RunLoop.main)
                .receive(on: RunLoop.main)
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
                    } else {
                        self?.pinStackView.stopPinInput()
                        self?.loginViewModel.pin = ""
                    }
                })
                .store(in: &bindings)
            
            loginViewModel.$isLoading
                .assign(to: \.isLoading, on: self)
                .store(in: &bindings)
            
            
            
            loginViewModel.$response
                .receive(on: RunLoop.main)
                .sink { [weak self] responseState in
                    switch responseState {
                    case .unknown:
                        print("Unknown")
                    case .success(let data) :
                        self?.navigateToSendFund(data)
                    case .failure(let error):
                        print(error.localizedDescription)
                        self?.view.makeToast(error.localizedDescription, duration: 2.0)
                    }
                }.store(in: &bindings)
            
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        
        loginViewModel.callLoginService()
    }
    
    func navigateToSendFund(_ data : UserData) {
        self.view.endEditing(true)
        let viewModel = SendFundViewModel()
        viewModel.maxBalance = data.accountInfo.balance
        
        let storyboard = Storyboards.sharedInstance.retrieveStoryBoard(BoardName.Main)
        let vc = storyboard.instantiateViewController(identifier: SendFundViewController.sceneIdentifier) { coder in
            SendFundViewController(coder: coder, data: data, viewModel: viewModel)
        }
        self.navigationController?.pushViewController(vc, animated: true)
        
        self.view.endEditing(true)
    }
    
}


extension LoginViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(range.location <= 32) {
            
            guard let text = textField.text else { return false }
            
            if((text.last == "_" && text.last == string.first) || (text.last == "." && text.last == string.first)) {
                return false
            } else {
                let cs = NSCharacterSet(charactersIn: ACCEPTABLE_CHARACTERS).inverted
                let filtered = string.components(separatedBy: cs).joined(separator: "")
                
                return (string == filtered)
            }
        } else {
            return false
        }

    }
}

extension LoginViewController: OTPDelegate {
    
    func didChangeValidity(isValid: Bool) {
        loginViewModel.pin = pinStackView.getOTP()
    }
    
}

