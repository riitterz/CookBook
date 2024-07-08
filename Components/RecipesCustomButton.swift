//
//  DifferentRecipesButton.swift
//  CookBookUIKit
//
//  Created by Macbook on 19.01.2024.
//

import UIKit

class RecipesCustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    func setupButton() {
        setStyle()
    }
    
    private func setStyle() {
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = UIColor(named: "AccentGray")
        titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        layer.cornerRadius = 25
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 1
    }
}
