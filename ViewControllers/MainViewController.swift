//
//  MainViewController.swift
//  CookBookUIKit
//
//  Created by Macbook on 19.01.2024.
//

import UIKit

protocol TodaysRecipeViewDelegate: AnyObject {
    func todaysRecipeViewDidTap(_ view: TodaysRecipeView, viewModel: RecipePreviewModel)
}

class MainViewController: UIViewController {
    
    let differentRecipesButtonTitles = ["Breakfast", "Soup", "Salads", "Vegetarian", "Vegan", "Gluten Free",  "Quick",  "Drinks", "Desserts"]
    let cuisinesRecipesButtonTitles = ["Italian Cuisine", "French Cuisine", "Chinese Cuisine", "Japanese Cuisine"]
    var models: [Model] = [Model]()
    var model: Model?
    var didSelectItem: ((RecipeModel) -> Void)?
    let recipeSetVC = RecipeSetViewController()
    
    private lazy var todaysRecipeView: TodaysRecipeView = {
        let view = TodaysRecipeView()
//        let tap = UITapGestureRecognizer(target: self, action: #selector(didSelected))
//        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    private let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "What would you like to cook?"
        search.layer.cornerRadius = 20
        search.searchTextField.font = .systemFont(ofSize: 18, weight: .medium)
        search.layer.borderColor = UIColor(named: "AccentGray")?.cgColor
        search.layer.borderWidth = 1
        search.searchTextField.backgroundColor = .white
        return search
    }()
    
    private let todayRecipeLabel: UILabel = {
        let label = UILabel()
        label.text = "Today's Gourmet Recipe"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(named: "AccentLightGray")
        return label
    }()
    
    private let differentRecipeLabel: UILabel = {
        let label = UILabel()
        label.text = "Different Recipes"
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = UIColor(named: "AccentLightGray")
        return label
    }()
    
    private let cuisinesRecipeLabel: UILabel = {
        let label = UILabel()
        label.text = "Most popular Cuisines"
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.textColor = UIColor(named: "AccentLightGray")
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getRecipe()
        setupSetButtons()
        addConstraints()
    }
    
    func getRecipe() {
        APICaller.shared.getRandomRecipe { result in
            switch result {
            case .success(let models):
                DispatchQueue.main.async {
                    guard let model = models.first else {
                        print("No recipe found")
                        return
                    }
                    print("Received model:", model)
                    let readyInMinutes = model.readyInMinutes ?? 0
                    let servings = model.servings ?? 0
                    let tap = UITapGestureRecognizer(target: self, action: #selector(self.didSelected))
                    self.todaysRecipeView.addGestureRecognizer(tap)
                    self.todaysRecipeView.configure(model: model, readyInMinutes: readyInMinutes, servings: servings)
                    let vc = RecipePreviewViewController()

                    APICaller.shared.getRecipe(with: model.id) { result in
                        switch result {
                        case .success(let recipe):
                            print(recipe)
                            let vm = RecipePreviewModel(id: model.id, title: model.title, image: model.image, healthScore: model.healthScore ?? 0, servings: servings, readyInMinutes: readyInMinutes)
                            APICaller.shared.getNutritionFacts(with: model.id) { nutritionResult in
                                switch nutritionResult {
                                case .success(let nutritionInfo):
                                    print(nutritionInfo)
                                    DispatchQueue.main.async {
                                        vc.configure(with: vm, readyInMinutes: readyInMinutes, servings: servings, healthScore: model.healthScore ?? 0, extendedIngredients: model.extendedIngredients, analyzedInstructions: model.analyzedInstructions, nutritionInfo: nutritionInfo)
                                        // Push the configured view controller
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }
                                case .failure(let error):
                                    print(error.localizedDescription)
                                }
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            case .failure(let error):
                print("Error:", error)
            }
        }
    }

    
    @objc private func didSelected() {
        let vc = RecipePreviewViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        getRecipe()
        
    }

    @objc func differentRecipesButtonTapped(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
            let vc = RecipeSetViewController()
            vc.selectedSetTitle.text = "\(title) Recipes"
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
            
            let buttonIndex = sender.tag
            
            switch buttonIndex {
                
            case 0:
                APICaller.shared.getBreakfastRecipes { result in
                    switch result {
                    case .success(let recipes):
                        vc.configure(with: recipes)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case 1:
                APICaller.shared.getSoupRecipes { result in
                    switch result {
                    case .success(let recipes):
                        vc.configure(with: recipes)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case 2:
                APICaller.shared.getSaladRecipes { result in
                    switch result {
                    case .success(let recipes):
                        vc.configure(with: recipes)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case 3:
                APICaller.shared.getVegetarianRecipes { result in
                    switch result {
                    case .success(let recipes):
                        vc.configure(with: recipes)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case 4:
                APICaller.shared.getVeganRecipes { result in
                    switch result {
                    case .success(let recipes):
                        vc.configure(with: recipes)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case 5:
                APICaller.shared.getGlutenFreeRecipes { result in
                    switch result {
                    case .success(let recipes):
                        vc.configure(with: recipes)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case 6:
                APICaller.shared.getQuickRecipes { result in
                    switch result {
                    case .success(let recipes):
                        vc.configure(with: recipes)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case 7:
                APICaller.shared.getDrinkRecipes { result in
                    switch result {
                    case .success(let recipes):
                        vc.configure(with: recipes)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case 8:
                APICaller.shared.getDessertsRecipes { result in
                    switch result {
                    case .success(let recipes):
                        vc.configure(with: recipes)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            default:
                break
            }
        }
    }
    
    @objc func popularCuisinesButtonTapped(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
            let vc = RecipeSetViewController()
            vc.selectedSetTitle.text = "\(title) Recipes"
            vc.delegate = self
            
            self.navigationController?.pushViewController(vc, animated: true)
            let buttonIndex = sender.tag
            
            switch buttonIndex {
            case 0:
                APICaller.shared.getItalianCuisineRecipes { result in
                    switch result {
                    case .success(let recipes):
                        vc.configure(with: recipes)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case 1:
                APICaller.shared.getFrenchCuisineRecipes { result in
                    switch result {
                    case .success(let recipes):
                        vc.configure(with: recipes)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case 2:
                APICaller.shared.getChineseCuisineRecipes { result in
                    switch result {
                    case .success(let recipes):
                        vc.configure(with: recipes)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case 3:
                APICaller.shared.getJapaneseCuisineRecipes { result in
                    switch result {
                    case .success(let recipes):
                        vc.configure(with: recipes)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            default:
                break
            }
        }
    }
}

extension MainViewController {
    
    private func setupSetButtons() {
        let numberOfColumns = 3
        let buttonWidth: CGFloat = 110
        let buttonHeight: CGFloat = 50
        let spacing: CGFloat = 13
        
        let differentRecipesTotalWidth = CGFloat(numberOfColumns) * buttonWidth + CGFloat(numberOfColumns - 1) * spacing
        let differentRecipesXOffset = (view.frame.width - differentRecipesTotalWidth) / 2
        
        for (index, title) in differentRecipesButtonTitles.enumerated() {
            let differentRecipesButton = RecipesCustomButton(type: .system)
            differentRecipesButton.frame = CGRect(
                x: differentRecipesXOffset + CGFloat(index % numberOfColumns) * (buttonWidth + spacing),
                y: CGFloat(index / numberOfColumns) * (buttonHeight + spacing) + 380,
                width: buttonWidth,
                height: buttonHeight
            )
            differentRecipesButton.setTitle(title, for: .normal)
            differentRecipesButton.addTarget(self, action: #selector(differentRecipesButtonTapped(_:)), for: .touchUpInside)
            differentRecipesButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            differentRecipesButton.tag = index
            view.addSubview(differentRecipesButton)
        }
        
        let numberOfBiggerColumns = 2
        let cuisuneButtonWidth: CGFloat = 170
        let cuisuneButtonHeight: CGFloat = 50
        let secondSpacing: CGFloat = 17
        
        let cuisinesRecipesTotalWidth = CGFloat(numberOfBiggerColumns) * cuisuneButtonWidth + CGFloat(numberOfBiggerColumns - 1) * secondSpacing
        let cuisinesRecipesXOffset = (view.frame.width - cuisinesRecipesTotalWidth) / 2
        
        for (index, title) in cuisinesRecipesButtonTitles.enumerated() {
            let cuisinesRecipesButton = RecipesCustomButton(type: .system)
            cuisinesRecipesButton.frame = CGRect(
                x: cuisinesRecipesXOffset + CGFloat(index % numberOfBiggerColumns) * (cuisuneButtonWidth + secondSpacing),
                y: CGFloat(index / numberOfBiggerColumns) * (cuisuneButtonHeight + secondSpacing) + 610,
                width: cuisuneButtonWidth,
                height: cuisuneButtonHeight
            )
            cuisinesRecipesButton.setTitle(title, for: .normal)
            cuisinesRecipesButton.addTarget(self, action: #selector(popularCuisinesButtonTapped(_:)), for: .touchUpInside)
            cuisinesRecipesButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            cuisinesRecipesButton.tag = index
            view.addSubview(cuisinesRecipesButton)
        }
    }
    
    func addConstraints() {
        view.addSubview(searchBar)
        view.addSubview(todayRecipeLabel)
        view.addSubview(differentRecipeLabel)
        view.addSubview(cuisinesRecipeLabel)
        view.addSubview(todaysRecipeView)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        todayRecipeLabel.translatesAutoresizingMaskIntoConstraints = false
        differentRecipeLabel.translatesAutoresizingMaskIntoConstraints = false
        cuisinesRecipeLabel.translatesAutoresizingMaskIntoConstraints = false
        todaysRecipeView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            searchBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 60)
        ])
        
        NSLayoutConstraint.activate([
            todayRecipeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            todayRecipeLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            todaysRecipeView.topAnchor.constraint(equalTo: todayRecipeLabel.bottomAnchor, constant: 15),
            todaysRecipeView.heightAnchor.constraint(equalToConstant: 150),
            todaysRecipeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            todaysRecipeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
        
        NSLayoutConstraint.activate([
            differentRecipeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            differentRecipeLabel.topAnchor.constraint(equalTo: todaysRecipeView.bottomAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            cuisinesRecipeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            cuisinesRecipeLabel.topAnchor.constraint(equalTo: differentRecipeLabel.bottomAnchor, constant: 200)
        ])
    }
}
extension MainViewController: TodaysRecipeViewDelegate {
    func todaysRecipeViewDidTap(_ view: TodaysRecipeView, viewModel: RecipePreviewModel) {
        let group = DispatchGroup()
        
        var recipe: Model?
        let viewModel: RecipePreviewModel? = nil
        
        group.enter()
        
        APICaller.shared.getRecipe(with: viewModel?.id ?? 0) { result in
            switch result {
            case .success(let fetchedRecipe):
                recipe = fetchedRecipe
            case .failure(let error):
                print("Error fetching recipe:", error.localizedDescription)
            }
            
            group.leave()
        }
        
        group.enter()
        var nutritionInfo: NutritionInfo?
        
        APICaller.shared.getNutritionFacts(with: viewModel?.id ?? 0) { result in
            switch result {
            case .success(let fetchedNutritionInfo):
                nutritionInfo = fetchedNutritionInfo
            case .failure(let error):
                print("Error fetching nutrition info:", error.localizedDescription)
            }
            
            group.leave()
        }
        
        group.notify(queue: .main) {
            guard let recipe = recipe, let nutritionInfo = nutritionInfo else {
                print("Failed to fetch both recipe and nutrition info")
                return
            }
            
            DispatchQueue.main.async {
                let vc = RecipePreviewViewController()
                vc.configure(with: viewModel!, readyInMinutes: recipe.readyInMinutes ?? 0, servings: recipe.servings ?? 0, healthScore: recipe.healthScore ?? 0, extendedIngredients: recipe.extendedIngredients, analyzedInstructions: recipe.analyzedInstructions, nutritionInfo: nutritionInfo)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }

    }
}

extension MainViewController: MainCollectionViewTableViewCellDelegate {
    
    func mainCollectionViewTableViewCellDidTapCell(_ cell: RecipeSetViewController, viewModel: RecipePreviewModel) {
        let group = DispatchGroup()
        
        var recipe: Model?
        
        group.enter()
        
        APICaller.shared.getRecipe(with: viewModel.id) { result in
            switch result {
            case .success(let fetchedRecipe):
                recipe = fetchedRecipe
            case .failure(let error):
                print("Error fetching recipe:", error.localizedDescription)
            }
            
            group.leave()
        }
        
        group.enter()
        var nutritionInfo: NutritionInfo?
        
        APICaller.shared.getNutritionFacts(with: viewModel.id) { result in
            switch result {
            case .success(let fetchedNutritionInfo):
                nutritionInfo = fetchedNutritionInfo
            case .failure(let error):
                print("Error fetching nutrition info:", error.localizedDescription)
            }
            
            group.leave()
        }
        
        group.notify(queue: .main) {
            guard let recipe = recipe, let nutritionInfo = nutritionInfo else {
                print("Failed to fetch both recipe and nutrition info")
                return
            }
            
            DispatchQueue.main.async {
                let vc = RecipePreviewViewController()
                vc.configure(with: viewModel, readyInMinutes: recipe.readyInMinutes ?? 0, servings: recipe.servings ?? 0, healthScore: recipe.healthScore ?? 0, extendedIngredients: recipe.extendedIngredients, analyzedInstructions: recipe.analyzedInstructions, nutritionInfo: nutritionInfo)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
