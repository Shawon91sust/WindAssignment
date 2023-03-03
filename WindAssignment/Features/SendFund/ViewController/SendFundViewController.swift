//
//  SendFundViewController.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 2/3/23.
//

import UIKit
import Reusable
import Combine

class SendFundViewController: UIViewController, StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    var sendFundViewModel =  SendFundViewModel()
    private var bindings = Set<AnyCancellable>()
    
    let userData : UserData
    
    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var recipientView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var recipientDetailsLabel: UILabel!
    @IBOutlet weak var gradientLabel: GradientLabel!
    
    @IBOutlet weak var balanceContainer: UIView!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var maxButton: RoundedButton!
    
    @IBOutlet weak var insufficientLabel: UILabel!
    @IBOutlet weak var addFundButton: RoundedButton!
    
    @IBOutlet weak var continueButton: BaseButton!
    
    var maxBalance : Double = 0.00
    var remainingBalance : Double = 0.00
    
    // MARK: - Initialization
    init?(coder: NSCoder, data: UserData) {
        self.userData = data
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use `init(coder:viewModel:)` to instantiate a `ViewController` instance.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
        setUpBindings()
    }
    
    
    
    func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        
        recipientView.applyShadow(cornerRadius: 8.0)
        
        let name = "@nadimh - 3CGH...UwvX"
        recipientDetailsLabel.text = userData.userInfo.userName
        recipientDetailsLabel.isHidden = true
        gradientLabel.label.text = "@nadimh - 3CGH...UwvX"
        

        balanceContainer.gradientBackground(colors: [UIColor("#F6E8F5").cgColor, UIColor("#F7EAE9").cgColor, UIColor("#F6EFE0").cgColor], startPoint: .unitCoordinate(.top), endPoint: .unitCoordinate(.bottomLeft), andRoundCornersWithRadius: 12.0)
        balanceContainer.gradientBorder(width: 1.0, colors: [UIColor("#6E50FF"), UIColor("#FFA450")], startPoint: .unitCoordinate(.topRight), endPoint: .unitCoordinate(.bottomLeft), andRoundCornersWithRadius: 12.0)
        
        inputField.font = AppFont.book.size(48.0)
        inputField.becomeFirstResponder()
        maxButton.type = .max
        maxButton.isSelect = true
        
        maxBalance = userData.accountInfo.balance
        sendFundViewModel.maxBalance = maxBalance
        remainingBalance = userData.accountInfo.balance
        balanceLabel.text = "Balance \(userData.accountInfo.currency) \(remainingBalance)"
        currencyLabel.text = userData.accountInfo.currency
        
        
        addFundButton.type = .addFund
        
        continueButton.type = .cont
        continueButton.isValid = false
    }
    
    func setupNavigation() {
        navigationBar.backButtonPressed = { _ in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    private func setUpBindings() {
        func bindViewToViewModel() {
            inputField.textPublisher
                .receive(on: DispatchQueue.main)
                .assign(to: \.inputValue, on: sendFundViewModel)
                .store(in: &bindings)
        
        }
        
        func bindViewModelToView() {
            sendFundViewModel.isInputValid
                .receive(on: RunLoop.main)
                .assign(to: \.isValid, on: self.continueButton)
                .store(in: &bindings)
            
            sendFundViewModel.maxSelected
                .receive(on: RunLoop.main)
                .assign(to: \.isSelect, on: self.maxButton)
                .store(in: &bindings)
            
            sendFundViewModel.remainingBalance
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] value in
                    
                    if let currency = self?.userData.accountInfo.currency {
                        self?.balanceLabel.text = "Balance \(currency) \(value)"
                    }
                })
                .store(in: &bindings)
            
            sendFundViewModel.insufficientBalance
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] insufficient in
                    print(insufficient)
                    
                    self?.insufficientLabel.isHidden = insufficient
                    self?.addFundButton.isHidden = insufficient
                })
                .store(in: &bindings)

//            loginViewModel.loginResult
//                .sink { completion in
//                    switch completion {
//                    case .failure(let error):
//                        print(error.localizedDescription)
//                        return
//                    case .finished:
//                        return
//                    }
//                } receiveValue: { [weak self] userData in
//                    self?.navigateToSendFund(userData)
//                }
//                .store(in: &bindings)
            
        }
        
        bindViewToViewModel()
        bindViewModelToView()
    }
    

    @IBAction func maxButtonAction(_ sender: Any) {
        inputField.text = "\(maxBalance)"
        NotificationCenter.default.post(name: UITextField.textDidChangeNotification, object: inputField)
        maxButton.isSelect = true
    }
    

}
