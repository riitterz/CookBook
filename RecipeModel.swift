//
//  RecipeModel.swift
//  CookBookUIKit
//
//  Created by Macbook on 30.12.2023.
//

import Foundation

struct RecipeModel: Decodable, Equatable {
    let id: Int
    let title: String
    let image: String
    let readyInMinutes: Int
    
    init(id: Int, title: String, image: String, readyInMinutes: Int) {
        self.id = id
        self.title = title
        self.image = image
        self.readyInMinutes = readyInMinutes
    }
}
