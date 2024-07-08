//
//  RecipeSetViewController.swift
//  CookBookUIKit
//
//  Created by Macbook on 19.01.2024.
//

import UIKit


protocol MainCollectionViewTableViewCellDelegate: AnyObject {
    func mainCollectionViewTableViewCellDidTapCell(_ cell: RecipeSetViewController, viewModel: RecipePreviewModel)
}

class RecipeSetViewController: UIViewController {
        
    weak var delegate: MainCollectionViewTableViewCellDelegate?
    
    var mainCollectionViewCell = MainCollectionViewCell()
    
    private var models: [Model] = []
    
    var selectedSetTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(named: "AccentLightGray")
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 180, height: 210)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        return collectionView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [selectedSetTitle, collectionView])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(stackView)
        collectionView.delegate = self
        collectionView.dataSource = self        
        addConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    func configure(with models: [Model]) {
        self.models = models
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    private func downloadTitleAt(indexPath: IndexPath) {
        
    }
    
    private func addConstraints() {
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension RecipeSetViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else {
            return UICollectionViewCell()
        }
        let model = models[indexPath.row]
        
        APICaller.shared.getRecipe(with: model.id) { result in
            switch result {
            case .success(let recipe):
                print(recipe)
                let readyInMinutes = model.readyInMinutes
                print(recipe)
                DispatchQueue.main.async {
                    cell.configure(with: RecipeModel(id: model.id, title: model.title, image: model.image, readyInMinutes: recipe.readyInMinutes ?? 0), readyInMinutes: recipe.readyInMinutes ?? 0)
                }
            case .failure(let error):
                print("Error:", error.localizedDescription)
            }
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2 - 20, height: 230)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = models[indexPath.row]
        let id = model.id
        
        APICaller.shared.getRecipe(with: id) { [weak self] result in
            switch result {
            case .success(_):
                guard let strongSelf = self else { return }
                let viewModel = RecipePreviewModel(id: model.id, title: model.title, image: model.image, healthScore: model.healthScore ?? 0, servings: model.servings ?? 0, readyInMinutes: model.readyInMinutes ?? 0)
                guard let delegate = strongSelf.delegate else {
                                print("Error: Delegate is nil")
                                return
                            }
                      delegate.mainCollectionViewTableViewCellDidTapCell(strongSelf, viewModel: viewModel)
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
}
