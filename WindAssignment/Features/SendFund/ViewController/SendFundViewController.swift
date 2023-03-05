//
//  SendFundViewController.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 2/3/23.
//

import UIKit
import Reusable
import Combine
import Kingfisher

class SendFundViewController: UIViewController, StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    var sendFundViewModel:  SendFundViewModel
    private var bindings = Set<AnyCancellable>()
    
    let userData : UserData
    
    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var recipientView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var recipientNameLabel: GradientLabel!
    @IBOutlet weak var walletAddressLabel: UILabel!
    //@IBOutlet weak var gradientLabel: GradientLabel!
    
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
    init?(coder: NSCoder, data: UserData, viewModel : SendFundViewModel) {
        self.userData = data
        self.sendFundViewModel = viewModel
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
        
        let placeHolderImage : UIImage? = .placeholderImage
        
        self.imgView.rounded()
        
        if let imageURLString = userData.userInfo.profileImage,  let imageURL = URL(string: imageURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
            self.imgView.kf.indicatorType = .activity
            self.imgView.kf.setImage(with: imageURL, placeholder: placeHolderImage, options: nil) { _ in
                
            }
        }
        
        
        recipientNameLabel.gradientColors = [ UIColor("6E50FF").cgColor, UIColor("FF50BA").cgColor]
        recipientNameLabel.text = userData.userInfo.userName
        
        walletAddressLabel.text = " - " + userData.userInfo.walletAddress
        balanceContainer.gradientBackground(colors: [UIColor("#F6E8F5").cgColor, UIColor("#F7EAE9").cgColor, UIColor("#F6EFE0").cgColor], startPoint: .unitCoordinate(.top), endPoint: .unitCoordinate(.bottomLeft), andRoundCornersWithRadius: 12.0)
        balanceContainer.gradientBorder(width: 1.0, colors: [UIColor("#6E50FF"), UIColor("#FFA450")], startPoint: .unitCoordinate(.topRight), endPoint: .unitCoordinate(.bottomLeft), andRoundCornersWithRadius: 12.0)
        
        maxButton.type = .max
        maxBalance = userData.accountInfo.balance
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
                        let readableValue = String(format: "%.5f", value)
                        self?.balanceLabel.text = "Balance \(currency) \(readableValue)"
                    }
                })
                .store(in: &bindings)
            
            sendFundViewModel.sufficientBalance
                .receive(on: RunLoop.main)
                .sink(receiveValue: { [weak self] sufficient in
                    print(sufficient)
                    self?.insufficientLabel.isHidden = sufficient
                    self?.addFundButton.isHidden = sufficient
                })
                .store(in: &bindings)
            
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
