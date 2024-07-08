//
//  RecipePreviewModel.swift
//  CookBookUIKit
//
//  Created by Macbook on 04.01.2024.
//

import Foundation

struct RecipeResponse: Decodable, Equatable {
    let recipes: [RecipePreviewModel]
}

struct RecipePreviewModel: Decodable, Equatable {
    let id: Int
    let title: String
    let image: String
    let healthScore: Int
    let servings: Int
    let readyInMinutes: Int
}
