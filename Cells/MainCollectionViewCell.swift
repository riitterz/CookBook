//
//  MainCollectionViewCell.swift
//  CookBookUIKit
//
//  Created by Macbook on 19.01.2024.
//

import UIKit
import SDWebImage

class MainCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MainCollectionViewCell"
    var didSelectItem: ((RecipeModel) -> Void)?
    private var recipeViewModel: RecipeModel?
    private var instructionCell: InstructionsCollectionViewCell?
    
     var imageView: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
         image.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        image.clipsToBounds = true
        image.layer.borderColor = UIColor(named: "AccentGray")?.cgColor
        image.layer.borderWidth = 1
        return image
    }()
    
    private var background: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor(named: "AccentGray")?.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [ .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "AccentGray")
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    
    private let timeImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(systemName: "stopwatch")
        image.tintColor = UIColor.red
        
        return image
    }()
    
    private let timeLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.red
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
    
    @objc func cellTapped() {
        guard let recipe = recipeViewModel else { return }
        didSelectItem?(recipe)
    }

    private func addConstraints() {
        contentView.addSubview(imageView)
        contentView.addSubview(background)
        background.addSubview(nameLabel)
        background.addSubview(timeImage)
        background.addSubview(timeLabel)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        background.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        timeImage.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false


        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            background.heightAnchor.constraint(equalToConstant: 65),
            background.widthAnchor.constraint(equalTo: imageView.widthAnchor),
            background.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -20),
            background.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 6),
            nameLabel.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            timeImage.widthAnchor.constraint(equalToConstant: 15),
            timeImage.heightAnchor.constraint(equalToConstant: 15),
            timeImage.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3),
            timeImage.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.leadingAnchor.constraint(equalTo: timeImage.trailingAnchor, constant: 3),
            timeLabel.centerYAnchor.constraint(equalTo: timeImage.centerYAnchor, constant: 0),
        ])
    }
    
    func configure(with model: RecipeModel, readyInMinutes: Int) {
        let minutes = "\(readyInMinutes) ~ min."
        imageView.sd_setImage(with: URL(string: model.image), completed: nil)
        nameLabel.text = model.title
        timeLabel.text = minutes
    }
}
