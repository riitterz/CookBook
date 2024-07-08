//
//  SearchCollectionViewCell.swift
//  CookBookUIKit
//
//  Created by Macbook on 10.02.2024.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    static let identifier = "SearchCollectionViewCell"
    
    private let cellBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "mealImage")
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.layer.borderWidth = 0.5
        image.layer.borderColor = UIColor(named: "AccentGray")?.cgColor
        
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Grilled Salmon with Lemon Herb Butter"
        label.textColor = UIColor(named: "AccentGray")
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 2
        
        return label
    }()
    
    private let timeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "stopwatch")
        image.tintColor = UIColor(named: "AccentLightGray")
        
        return image
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "70 min."
        label.textColor = UIColor(named: "AccentLightGray")
        label.font = .systemFont(ofSize: 12, weight: .medium)
        
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
        addSubview(cellBackground)
        cellBackground.addSubview(image)
        cellBackground.addSubview(nameLabel)
        cellBackground.addSubview(timeImage)
        cellBackground.addSubview(timeLabel)

        cellBackground.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        timeImage.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            cellBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            cellBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 130),
            image.widthAnchor.constraint(equalTo: image.heightAnchor),
            image.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: 9),
            image.topAnchor.constraint(equalTo: cellBackground.topAnchor, constant: 9),
            image.bottomAnchor.constraint(equalTo: cellBackground.bottomAnchor, constant: -9),
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -12),
            nameLabel.topAnchor.constraint(equalTo: cellBackground.topAnchor, constant: 9),
        ])
        
        NSLayoutConstraint.activate([
            timeImage.heightAnchor.constraint(equalToConstant: 18),
            timeImage.widthAnchor.constraint(equalToConstant: 18),
            timeImage.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 12),
            timeImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 13)
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: timeImage.trailingAnchor, constant: 5),
            timeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15)
        ])
    }
}
