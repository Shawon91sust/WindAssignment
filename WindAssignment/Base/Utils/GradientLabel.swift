//
//  GradientLabel.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 3/3/23.
//

import UIKit


class GradientLabel: UIStackView {
      lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = AppFont.book.size(16.0)
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        axis = .vertical
        alignment = .leading

        addArrangedSubview(label)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let gradient = UIImage.gradientImage(bounds: label.bounds, colors: [ UIColor("6E50FF"), UIColor("FF50BA")])
        label.textColor = UIColor(patternImage: gradient)
    }
}
