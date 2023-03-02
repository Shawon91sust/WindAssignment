//
//  SendFundViewController.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 2/3/23.
//

import UIKit
import Reusable

class SendFundViewController: UIViewController, StoryboardSceneBased {
    static let sceneStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    //var filterViewModel : FilterViewModel
    //private var bindings = Set<AnyCancellable>()
    
    @IBOutlet weak var navigationBar: NavigationBar!
    @IBOutlet weak var recipientView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var recipientDetailsLabel: UILabel!
    @IBOutlet weak var gradientLabel: GradientLabel!
    
    @IBOutlet weak var balanceContainer: UIView!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var maxButton: RoundedButton!
    
    
    @IBOutlet weak var continueButton: BaseButton!
    
//    // MARK: - Initialization
//    init?(coder: NSCoder, model: SubordinateLocationModel) {
//        self.subLocationModel = model
//        super.init(coder: coder)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("Use `init(coder:viewModel:)` to instantiate a `ViewController` instance.")
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
    }
    
    
    
    func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        
        recipientView.applyShadow(cornerRadius: 8.0)
        
        let name = "@nadimh - 3CGH...UwvX"
        recipientDetailsLabel.text = name
        recipientDetailsLabel.isHidden = true
        gradientLabel.label.text = "@nadimh - 3CGH...UwvX"
        

        balanceContainer.gradientBackground(colors: [UIColor("#F6E8F5").cgColor, UIColor("#F7EAE9").cgColor, UIColor("#F6EFE0").cgColor], startPoint: .unitCoordinate(.top), endPoint: .unitCoordinate(.bottomLeft), andRoundCornersWithRadius: 12.0)
        balanceContainer.gradientBorder(width: 1.0, colors: [UIColor("#6E50FF"), UIColor("#FFA450")], startPoint: .unitCoordinate(.topRight), endPoint: .unitCoordinate(.bottomLeft), andRoundCornersWithRadius: 12.0)
        
        inputField.font = AppFont.book.size(48.0)
        maxButton.isSelect = true
        
        continueButton.type = .cont
        continueButton.isValid = true
    }
    
    func setupNavigation() {
        navigationBar.backButtonPressed = { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    

    

}
