//
//  RecipeInfoView.swift
//  CookBookUIKit
//
//  Created by Macbook on 29.01.2024.
//

import UIKit

class RecipeInfoView: UIView {

     let previewImage: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.layer.borderColor = UIColor(named: "AccentGray")?.cgColor
        image.layer.borderWidth = 0.5
        return image
    }()

     let previewName: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 3
        label.textColor = UIColor(named: "AccentGray")
        return label
    }()
    
    private let mainInfoChart: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor(named: "AccentLightGray")?.cgColor
        view.layer.borderWidth = 1
        return view
    }()

     let previewTimerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    let previewServingsLabel: UILabel = {
       let label = UILabel()
       label.textColor = .red
       label.font = .systemFont(ofSize: 12, weight: .semibold)
       return label
   }()
    
    let previewHealthScoreLabel: UILabel = {
       let label = UILabel()
       label.textColor = .red
       label.font = .systemFont(ofSize: 12, weight: .semibold)
       return label
   }()
    
    private let mainInfoChartVerticalLine1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "AccentLightGray")
        return view
    }()
    
    private let mainInfoChartVerticalLine2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "AccentLightGray")
        return view
    }()

    private let nutritionalFactsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "AccentLightGray")
        label.text = "Nutritional Facts"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()

    private let nutritionalFactsChart: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor(named: "AccentLightGray")?.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 20
        return view
    }()

    private let chartHorizontalTopLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "AccentLightGray")
        return view
    }()

    private let chartVerticalLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "AccentLightGray")
        return view
    }()

     let caloriesLabel: UILabel = {
        let label = UILabel()
        label.text = "Calories"
        label.textColor = UIColor(named: "AccentGray")
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

     let caloriesResult: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "AccentLightGray")
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()

     let fatsLabel: UILabel = {
        let label = UILabel()
        label.text = "Fats"
        label.textColor = UIColor(named: "AccentGray")
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

     let fatsResult: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "AccentLightGray")
         label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()

     let proteinLabel: UILabel = {
        let label = UILabel()
        label.text = "Protein"
        label.textColor = UIColor(named: "AccentGray")
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

     let proteinResult: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "AccentLightGray")
         label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()

     let carbLabel: UILabel = {
        let label = UILabel()
        label.text = "Carb."
        label.textColor = UIColor(named: "AccentGray")
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()

     let carbResult: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "AccentLightGray")
         label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
        
    private let chartView = UIView()

     let chartCollectionView: UICollectionView = {
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
         collectionView.isScrollEnabled = true
        collectionView.register(IngredientsCollectionViewCell.self, forCellWithReuseIdentifier: IngredientsCollectionViewCell.identifier)
         collectionView.register(InstructionsCollectionViewCell.self, forCellWithReuseIdentifier: InstructionsCollectionViewCell.identifier)
        return collectionView
    }()

     let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Ingredients", "Instructions"])
        segmentedControl.tintColor = UIColor(named: "AccentGray")
        segmentedControl.backgroundColor = .white
        segmentedControl.layer.borderColor = UIColor(named: "AccentGray")?.cgColor
        segmentedControl.layer.borderWidth = 1
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.isUserInteractionEnabled = true
        segmentedControl.selectedSegmentTintColor = UIColor(named: "AccentGray")
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .valueChanged)
        segmentedControl.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor(named: "AccentLightGray") ?? .black
        ], for: .normal)

        return segmentedControl
    }()
    
    var viewArray: [UICollectionView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        addConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        chartCollectionView.reloadData()

        if sender == self.segmentedControl {
            let selectedSegmentIndex = sender.selectedSegmentIndex
        }
    }

    private func addConstraint() {
        addSubview(previewImage)
        addSubview(previewName)
        let guide1 = UILayoutGuide()
        let guide2 = UILayoutGuide()

        mainInfoChart.addLayoutGuide(guide1)
        mainInfoChart.addLayoutGuide(guide2)
        
        addSubview(mainInfoChart)
        
        mainInfoChart.addSubview(mainInfoChartVerticalLine1)
        mainInfoChart.addSubview(mainInfoChartVerticalLine2)
        mainInfoChart.addSubview(previewTimerLabel)
        mainInfoChart.addSubview(previewServingsLabel)
        mainInfoChart.addSubview(previewHealthScoreLabel)

        addSubview(nutritionalFactsLabel)
        addSubview(nutritionalFactsChart)

        nutritionalFactsChart.addSubview(chartHorizontalTopLine)
        nutritionalFactsChart.addSubview(chartVerticalLine)

        nutritionalFactsChart.addSubview(caloriesLabel)
        nutritionalFactsChart.addSubview(fatsLabel)
        nutritionalFactsChart.addSubview(proteinLabel)
        nutritionalFactsChart.addSubview(carbLabel)

        nutritionalFactsChart.addSubview(caloriesResult)
        nutritionalFactsChart.addSubview(fatsResult)
        nutritionalFactsChart.addSubview(proteinResult)
        nutritionalFactsChart.addSubview(carbResult)

        addSubview(segmentedControl)
        addSubview(chartView)
        chartView.addSubview(chartCollectionView)
        previewImage.translatesAutoresizingMaskIntoConstraints = false
        previewName.translatesAutoresizingMaskIntoConstraints = false

        previewTimerLabel.translatesAutoresizingMaskIntoConstraints = false
        previewServingsLabel.translatesAutoresizingMaskIntoConstraints = false
        previewHealthScoreLabel.translatesAutoresizingMaskIntoConstraints = false

        mainInfoChart.translatesAutoresizingMaskIntoConstraints = false
        mainInfoChartVerticalLine1.translatesAutoresizingMaskIntoConstraints = false
        mainInfoChartVerticalLine2.translatesAutoresizingMaskIntoConstraints = false
        
        nutritionalFactsLabel.translatesAutoresizingMaskIntoConstraints = false
        nutritionalFactsChart.translatesAutoresizingMaskIntoConstraints = false
        chartHorizontalTopLine.translatesAutoresizingMaskIntoConstraints = false
        chartVerticalLine.translatesAutoresizingMaskIntoConstraints = false

        caloriesLabel.translatesAutoresizingMaskIntoConstraints = false
        fatsLabel.translatesAutoresizingMaskIntoConstraints = false
        proteinLabel.translatesAutoresizingMaskIntoConstraints = false
        carbLabel.translatesAutoresizingMaskIntoConstraints = false

        caloriesResult.translatesAutoresizingMaskIntoConstraints = false
        fatsResult.translatesAutoresizingMaskIntoConstraints = false
        proteinResult.translatesAutoresizingMaskIntoConstraints = false
        carbResult.translatesAutoresizingMaskIntoConstraints = false

        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            previewImage.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            previewImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            previewImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            previewImage.heightAnchor.constraint(equalTo: previewImage.widthAnchor, constant: 0)
        ])

        NSLayoutConstraint.activate([
            previewName.topAnchor.constraint(equalTo: previewImage.bottomAnchor, constant: 15),
            previewName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            previewName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])

        NSLayoutConstraint.activate([
            previewTimerLabel.centerXAnchor.constraint(equalTo: guide1.centerXAnchor),
            previewTimerLabel.centerYAnchor.constraint(equalTo: mainInfoChart.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            previewServingsLabel.centerXAnchor.constraint(equalTo: mainInfoChart.centerXAnchor),
            previewServingsLabel.centerYAnchor.constraint(equalTo: mainInfoChart.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            previewHealthScoreLabel.centerXAnchor.constraint(equalTo: guide2.centerXAnchor),
            previewHealthScoreLabel.centerYAnchor.constraint(equalTo: mainInfoChart.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            mainInfoChart.heightAnchor.constraint(equalToConstant: 30),
            mainInfoChart.topAnchor.constraint(equalTo: previewName.bottomAnchor, constant: 15),
            mainInfoChart.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            mainInfoChart.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])

        NSLayoutConstraint.activate([
            guide1.widthAnchor.constraint(equalTo: mainInfoChart.widthAnchor, multiplier: 1/3),
            guide2.widthAnchor.constraint(equalTo: mainInfoChart.widthAnchor, multiplier: 1/3),
            guide1.leadingAnchor.constraint(equalTo: mainInfoChart.leadingAnchor),
            guide2.trailingAnchor.constraint(equalTo: mainInfoChart.trailingAnchor),
            guide1.topAnchor.constraint(equalTo: mainInfoChart.topAnchor),
            guide2.topAnchor.constraint(equalTo: mainInfoChart.topAnchor),
            guide1.bottomAnchor.constraint(equalTo: mainInfoChart.bottomAnchor),
            guide2.bottomAnchor.constraint(equalTo: mainInfoChart.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            mainInfoChartVerticalLine1.widthAnchor.constraint(equalToConstant: 1),
            mainInfoChartVerticalLine2.widthAnchor.constraint(equalToConstant: 1),
            mainInfoChartVerticalLine1.leadingAnchor.constraint(equalTo: guide1.trailingAnchor),
            mainInfoChartVerticalLine2.trailingAnchor.constraint(equalTo: guide2.leadingAnchor),
            mainInfoChartVerticalLine1.topAnchor.constraint(equalTo: mainInfoChart.topAnchor),
            mainInfoChartVerticalLine2.topAnchor.constraint(equalTo: mainInfoChart.topAnchor),
            mainInfoChartVerticalLine1.bottomAnchor.constraint(equalTo: mainInfoChart.bottomAnchor),
            mainInfoChartVerticalLine2.bottomAnchor.constraint(equalTo: mainInfoChart.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            nutritionalFactsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            nutritionalFactsLabel.topAnchor.constraint(equalTo: mainInfoChart.bottomAnchor, constant: 15)
        ])

        NSLayoutConstraint.activate([
            nutritionalFactsChart.heightAnchor.constraint(equalToConstant: 80),
            nutritionalFactsChart.centerXAnchor.constraint(equalTo: centerXAnchor),
            nutritionalFactsChart.topAnchor.constraint(equalTo: nutritionalFactsLabel.bottomAnchor, constant: 15),
            nutritionalFactsChart.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            nutritionalFactsChart.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])

        NSLayoutConstraint.activate([
            chartHorizontalTopLine.heightAnchor.constraint(equalToConstant: 1),
            chartHorizontalTopLine.widthAnchor.constraint(equalTo: nutritionalFactsChart.widthAnchor, constant: 0),
            chartHorizontalTopLine.topAnchor.constraint(equalTo: nutritionalFactsChart.topAnchor, constant: 40)
        ])
        
        NSLayoutConstraint.activate([
            chartVerticalLine.heightAnchor.constraint(equalToConstant: 80),
            chartVerticalLine.widthAnchor.constraint(equalToConstant: 1),
            chartVerticalLine.centerYAnchor.constraint(equalTo: nutritionalFactsChart.centerYAnchor, constant: 0),
            chartVerticalLine.centerXAnchor.constraint(equalTo: nutritionalFactsChart.centerXAnchor, constant: 0)
        ])

        NSLayoutConstraint.activate([
            caloriesLabel.leadingAnchor.constraint(equalTo: nutritionalFactsChart.leadingAnchor, constant: 10),
            fatsLabel.leadingAnchor.constraint(equalTo: nutritionalFactsChart.leadingAnchor, constant: 10),
            caloriesLabel.topAnchor.constraint(equalTo: nutritionalFactsChart.topAnchor, constant: 10),
            fatsLabel.topAnchor.constraint(equalTo: chartHorizontalTopLine.topAnchor, constant: 10),

            proteinLabel.leadingAnchor.constraint(equalTo: chartVerticalLine.trailingAnchor, constant: 10),
            carbLabel.leadingAnchor.constraint(equalTo: chartVerticalLine.trailingAnchor, constant: 10),
            proteinLabel.topAnchor.constraint(equalTo: nutritionalFactsChart.topAnchor, constant: 10),
            carbLabel.topAnchor.constraint(equalTo: chartHorizontalTopLine.topAnchor, constant: 10),
        ])

        NSLayoutConstraint.activate([
            caloriesResult.trailingAnchor.constraint(equalTo: chartVerticalLine.leadingAnchor, constant: -10),
            fatsResult.trailingAnchor.constraint(equalTo: chartVerticalLine.leadingAnchor, constant: -10),
            caloriesResult.centerYAnchor.constraint(equalTo: caloriesLabel.centerYAnchor),
            fatsResult.centerYAnchor.constraint(equalTo: fatsLabel.centerYAnchor),

            proteinResult.trailingAnchor.constraint(equalTo: nutritionalFactsChart.trailingAnchor, constant: -10),
            carbResult.trailingAnchor.constraint(equalTo: nutritionalFactsChart.trailingAnchor, constant: -10),
            proteinResult.centerYAnchor.constraint(equalTo: proteinLabel.centerYAnchor),
            carbResult.centerYAnchor.constraint(equalTo: carbLabel.centerYAnchor),
        ])

        NSLayoutConstraint.activate([
             segmentedControl.heightAnchor.constraint(equalToConstant: 40),
            segmentedControl.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            segmentedControl.topAnchor.constraint(equalTo: nutritionalFactsChart.bottomAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
             segmentedControl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
        ])

        NSLayoutConstraint.activate([
            chartView.heightAnchor.constraint(equalToConstant: 220),
            chartView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            chartView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            chartView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            chartView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0)

        ])
        
        NSLayoutConstraint.activate([
            chartCollectionView.topAnchor.constraint(equalTo: chartView.topAnchor),
            chartCollectionView.leadingAnchor.constraint(equalTo: chartView.leadingAnchor),
            chartCollectionView.trailingAnchor.constraint(equalTo: chartView.trailingAnchor),
            chartCollectionView.bottomAnchor.constraint(equalTo: chartView.bottomAnchor)
        ])
    }
}
