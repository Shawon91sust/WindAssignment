//
//  NavigationBarWithButton.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 2/3/23.
//

import Foundation
import UIKit

final class NavigationBarWithButton: UIView {
    
    private static let NIB_NAME = "NavigationBarWithButton"
    
    @IBOutlet private var view: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var firstButton: UIButton!
    @IBOutlet private weak var secondButton: UIButton!
    
    var firstButtonPressed: ((UIButton?) -> Void)?
    var secondButtonPressed: ((UIButton?) -> Void)?
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    
    override func awakeFromNib() {
        initWithNib()
    }
    
    private func initWithNib() {
        Bundle.main.loadNibNamed(NavigationBarWithButton.NIB_NAME, owner: self, options: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        setupLayout()
    }
    
    @IBAction func firstButtonAction(sender: UIButton) {
        firstButtonPressed?(sender)
    }
    
    @IBAction func secondButtonAction(sender: UIButton) {
        secondButtonPressed?(sender)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate(
            [
                view.topAnchor.constraint(equalTo: topAnchor),
                view.leadingAnchor.constraint(equalTo: leadingAnchor),
                view.bottomAnchor.constraint(equalTo: bottomAnchor),
                view.trailingAnchor.constraint(equalTo: trailingAnchor)
            ]
        )
    }
}
