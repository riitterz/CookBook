//
//  InstructionsCollectionViewCell.swift
//  CookBookUIKit
//
//  Created by Macbook on 29.01.2024.
//

import UIKit

class InstructionsCollectionViewCell: UICollectionViewCell {
    static let identifier = "InstructionsCollectionViewCell"
    
    private let instructionOrderBackground: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        return view
    }()

     let instructionOrder: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "AccentGray")
        label.numberOfLines = 10
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .light)
         return label
    }()

    private let cellBackground: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()

     let instructionStep: UILabel = {
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
        addSubview(cellBackground)
        cellBackground.addSubview(instructionStep)
        addSubview(instructionOrderBackground)
        instructionOrderBackground.addSubview(instructionOrder)
        
        cellBackground.translatesAutoresizingMaskIntoConstraints = false
        instructionStep.translatesAutoresizingMaskIntoConstraints = false
        instructionOrderBackground.translatesAutoresizingMaskIntoConstraints = false
        instructionOrder.translatesAutoresizingMaskIntoConstraints = false

         NSLayoutConstraint.activate([
            cellBackground.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellBackground.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            cellBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

         NSLayoutConstraint.activate([
             instructionStep.leadingAnchor.constraint(equalTo: cellBackground.leadingAnchor, constant: 10),
             instructionStep.trailingAnchor.constraint(equalTo: cellBackground.trailingAnchor, constant: -10),
             instructionStep.centerXAnchor.constraint(equalTo: cellBackground.centerXAnchor),
             instructionStep.centerYAnchor.constraint(equalTo: cellBackground.centerYAnchor)
         ])

         NSLayoutConstraint.activate([
             instructionOrderBackground.heightAnchor.constraint(equalToConstant: 50),
             instructionOrderBackground.widthAnchor.constraint(equalToConstant: 50),
             instructionOrderBackground.centerXAnchor.constraint(equalTo: cellBackground.centerXAnchor),
             instructionOrderBackground.bottomAnchor.constraint(equalTo: cellBackground.topAnchor, constant: 15)
         ])

         NSLayoutConstraint.activate([
             instructionOrder.centerXAnchor.constraint(equalTo: instructionOrderBackground.centerXAnchor),
             instructionOrder.centerYAnchor.constraint(equalTo: instructionOrderBackground.centerYAnchor)
         ])
    }
    func configure(with step: Step) {
        instructionOrder.text = "\(step.number)"
        instructionStep.text = step.step
    }
}

