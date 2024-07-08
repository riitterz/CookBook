//
//  RecipePreviewViewController.swift
//  CookBookUIKit
//
//  Created by Macbook on 30.12.2023.
//

import UIKit
import SDWebImage

class RecipePreviewViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let recipeInfo = RecipeInfoView()
    private let instructionsCollectionViewCell = InstructionsCollectionViewCell()
    private var steps: [Step] = []
    private var ingredients: [Ingredients] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        recipeInfo.chartCollectionView.delegate = self
        recipeInfo.chartCollectionView.dataSource = self
        scrollView.isUserInteractionEnabled = true
        addConstraints()
    }
    
    private func addConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(recipeInfo)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            recipeInfo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            recipeInfo.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            recipeInfo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -100),
            recipeInfo.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            recipeInfo.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            recipeInfo.heightAnchor.constraint(equalToConstant: CGFloat(scrollView.bounds.height + 1000))
        ])
    }
    
    public func configure(with model: RecipePreviewModel, readyInMinutes: Int, servings: Int, healthScore: Int, extendedIngredients: [Ingredients]?, analyzedInstructions: [Instruction]?, nutritionInfo: NutritionInfo?) {
        let minutes = "\(readyInMinutes) minutes"
        let servings = "\(servings) servings"
        let healthScore = "Health Score: \(healthScore)"

        recipeInfo.previewImage.sd_setImage(with: URL(string: model.image), completed: nil)
        recipeInfo.previewName.text = model.title
        recipeInfo.previewHealthScoreLabel.text = healthScore
        recipeInfo.previewServingsLabel.text = servings
        recipeInfo.previewTimerLabel.text = minutes
        if let ingredientsStrings = extendedIngredients {
            self.ingredients = ingredientsStrings
            recipeInfo.chartCollectionView.reloadData()
        }

        if let instructions = analyzedInstructions?.flatMap({ $0.steps }) {
            let flatInstructions = instructions.flatMap { $0 }
            self.steps = flatInstructions
            recipeInfo.chartCollectionView.reloadData()
        }

        if let nutritionInfo = nutritionInfo {
            recipeInfo.caloriesResult.text = nutritionInfo.calories
            recipeInfo.fatsResult.text = nutritionInfo.fat
            recipeInfo.carbResult.text = nutritionInfo.carbs
            recipeInfo.proteinResult.text = nutritionInfo.protein
        }
    }
}

extension RecipePreviewViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if recipeInfo.segmentedControl.selectedSegmentIndex == 0 {
            return ingredients.count
        } else {
            return steps.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if recipeInfo.segmentedControl.selectedSegmentIndex == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IngredientsCollectionViewCell.identifier, for: indexPath) as! IngredientsCollectionViewCell
            let ingredient = ingredients[indexPath.item]
            cell.configure(with: ingredient)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InstructionsCollectionViewCell.identifier, for: indexPath) as! InstructionsCollectionViewCell
            let step = steps[indexPath.item]
            cell.configure(with: step)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if recipeInfo.segmentedControl.selectedSegmentIndex == 0 {
            let padding: CGFloat = 10
            let ingredient = ingredients[indexPath.item].original 
            let labelHeight = NSString(string: ingredient).boundingRect(with: CGSize(width: UIScreen.main.bounds.width / 2 - 20, height: .greatestFiniteMagnitude),
                                                                        options: [.usesLineFragmentOrigin],
                                                                        attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)],
                                                                        context: nil).height
            return CGSize(width: UIScreen.main.bounds.width - 30, height: labelHeight + padding)

        } else {
            let step = steps[indexPath.item].step

            let labelHeight = NSString(string: step).boundingRect(with: CGSize(width: UIScreen.main.bounds.width / 2 - 30, height: .greatestFiniteMagnitude),
                                                                        options: [.usesLineFragmentOrigin],
                                                                        attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15)],
                                                                        context: nil).height
            return CGSize(width: UIScreen.main.bounds.width - 30, height: labelHeight + 50)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if recipeInfo.segmentedControl.selectedSegmentIndex == 0 {
            return 10
        } else {
            return 4
        }
    }
}
