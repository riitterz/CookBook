//
//  NutritualFactsModel.swift
//  CookBookUIKit
//
//  Created by Macbook on 18.01.2024.
//

import Foundation

struct NutritionInfo: Codable {
    let calories: String
    let carbs: String
    let fat: String
    let protein: String
}

struct Nutritient: Codable {
    let amount: String
    let title: String
    let percentOfDailyNeeds: Double
}


