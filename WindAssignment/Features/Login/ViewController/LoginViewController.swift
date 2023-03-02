//
//  LoginViewController.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 1/3/23.
//

import UIKit
import Reusable

class LoginViewController: BaseViewController, StoryboardSceneBased {
    
    static let sceneStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    //private var loginViewModel = LoginViewModel()
    //private var bindings = Set<AnyCancellable>()
    
    @IBOutlet weak var userNameField: LeftIconTextField!
    @IBOutlet weak var pinField: PinField!
    @IBOutlet weak var loginButton: BaseButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    
    func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        userNameField.type = .userNameField
        loginButton.type = .cont
        loginButton.isValid = true
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        
        let storyboard = Storyboards.sharedInstance.retrieveStoryBoard(BoardName.Main)
        let vc = SendFundViewController.instantiate()
        //storyboard.instantiateViewController(identifier: FindInMapViewController.sceneIdentifier) { coder in
            //FindInMapViewController(coder: coder, model: subLocation, imgPath: subordinate.imgPath)
        //}
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        self.view.endEditing(true)
    }
    
}

