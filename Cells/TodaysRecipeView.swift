//
//  TodaysRecipeView.swift
//  CookBookUIKit
//
//  Created by Macbook on 10.02.2024.
//

import UIKit

class TodaysRecipeView: UIView {
    
    private let background: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor(named: "AccentGray")?.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.borderWidth = 0.5
        image.layer.borderColor = UIColor(named: "AccentGray")?.cgColor
        
        return image
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "AccentGray")
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 4
        
        return label
    }()
    
    private let mainInfoChart: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor(named: "AccentLightGray")?.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let mainInfoChartVerticalLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "AccentLightGray")
        return view
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        label.font = .systemFont(ofSize: 12, weight: .medium)
        
        return label
    }()
    
    private let servingsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        label.font = .systemFont(ofSize: 12, weight: .medium)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    func addConstraint() {
        addSubview(background)
        background.addSubview(image)
        background.addSubview(nameLabel)
        background.addSubview(mainInfoChart)
        mainInfoChart.addSubview(timeLabel)
        mainInfoChart.addSubview(servingsLabel)
        mainInfoChart.addSubview(mainInfoChartVerticalLine)
        let guide1 = UILayoutGuide()
        let guide2 = UILayoutGuide()

        mainInfoChart.addLayoutGuide(guide1)
        mainInfoChart.addLayoutGuide(guide2)
        
        background.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        mainInfoChart.translatesAutoresizingMaskIntoConstraints = false
        mainInfoChartVerticalLine.translatesAutoresizingMaskIntoConstraints = false
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        servingsLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: topAnchor),
            background.bottomAnchor.constraint(equalTo: bottomAnchor),
            background.leadingAnchor.constraint(equalTo: leadingAnchor),
            background.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 130),
            image.widthAnchor.constraint(equalTo: image.heightAnchor),
            image.leadingAnchor.constraint(equalTo: background.leadingAnchor, constant: 9),
            image.topAnchor.constraint(equalTo: background.topAnchor, constant: 9),
            image.bottomAnchor.constraint(equalTo: background.bottomAnchor, constant: -9),
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -12),
            nameLabel.topAnchor.constraint(equalTo: background.topAnchor, constant: 9),
        ])
        
        NSLayoutConstraint.activate([
            mainInfoChart.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            mainInfoChart.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 12),
            mainInfoChart.trailingAnchor.constraint(equalTo: background.trailingAnchor, constant: -12),
            mainInfoChart.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            guide1.widthAnchor.constraint(equalTo: mainInfoChart.widthAnchor, multiplier: 1/2),
            guide2.widthAnchor.constraint(equalTo: mainInfoChart.widthAnchor, multiplier: 1/2),
            guide1.leadingAnchor.constraint(equalTo: mainInfoChart.leadingAnchor),
            guide2.trailingAnchor.constraint(equalTo: mainInfoChart.trailingAnchor),
            guide1.topAnchor.constraint(equalTo: mainInfoChart.topAnchor),
            guide2.topAnchor.constraint(equalTo: mainInfoChart.topAnchor),
            guide1.bottomAnchor.constraint(equalTo: mainInfoChart.bottomAnchor),
            guide2.bottomAnchor.constraint(equalTo: mainInfoChart.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            mainInfoChartVerticalLine.widthAnchor.constraint(equalToConstant: 1),
            mainInfoChartVerticalLine.leadingAnchor.constraint(equalTo: guide1.trailingAnchor),
            mainInfoChartVerticalLine.topAnchor.constraint(equalTo: mainInfoChart.topAnchor),
            mainInfoChartVerticalLine.bottomAnchor.constraint(equalTo: mainInfoChart.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.centerXAnchor.constraint(equalTo: guide1.centerXAnchor),
            timeLabel.centerYAnchor.constraint(equalTo: guide1.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            servingsLabel.centerXAnchor.constraint(equalTo: guide2.centerXAnchor),
            servingsLabel.centerYAnchor.constraint(equalTo: guide2.centerYAnchor)
        ])
    }
    func configure(model: Model, readyInMinutes: Int, servings: Int) {
        let readyInMinutes = "\(readyInMinutes) minutes"
        let servings = "\(servings) servings"
        image.sd_setImage(with: URL(string: model.image), completed: nil)
        nameLabel.text = model.title
        timeLabel.text = readyInMinutes
        servingsLabel.text = servings
    }
}
