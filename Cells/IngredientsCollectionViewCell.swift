//
//  IngredientsCollectionViewCell.swift
//  CookBookUIKit
//
//  Created by Macbook on 28.01.2024.
//

import UIKit

class IngredientsCollectionViewCell: UICollectionViewCell {
    static let identifier = "IngredientsCollectionViewCell"
    
    private let background: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    var ingredientsName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "AccentGray")
        label.numberOfLines = 10
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
         return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("DEBUG")
    }
    
    private func addConstraints() {
        addSubview(background)
        background.addSubview(ingredientsName)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        ingredientsName.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
            background.topAnchor.constraint(equalTo: topAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            ingredientsName.centerXAnchor.constraint(equalTo: background.centerXAnchor),
            ingredientsName.topAnchor.constraint(equalTo: background.topAnchor, constant: 7),
            ingredientsName.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 10),
            ingredientsName.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -15),
            ingredientsName.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -7)
        ])
    }
    func configure(with ingredient: Ingredients) {
        ingredientsName.text = ingredient.original
    }
}
