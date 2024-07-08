//
//  Model.swift
//  CookBookUIKit
//
//  Created by Macbook on 22.12.2023.
//

import Foundation

struct RandomRecipeResponse: Decodable, Equatable {
    let recipes: [Model]
}

struct TrendingTitleResponse: Decodable, Equatable {
    let results: [Model]
}

struct Model: Decodable, Equatable {
    let id: Int
    var title: String
    let image: String
    let healthScore: Int?
    let servings: Int?
    let readyInMinutes: Int?
    let extendedIngredients: [Ingredients]?
    let analyzedInstructions: [Instruction]?
}
