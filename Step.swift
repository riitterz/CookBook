//
//  InstructionsModel.swift
//  CookBookUIKit
//
//  Created by Macbook on 30.01.2024.
//

import Foundation

struct Ingredients: Decodable, Equatable {
    let original: String
}

struct Instruction: Decodable, Equatable {
    let name: String
    let steps: [Step]?
}

struct Step: Decodable, Equatable {
    let number: Int
    let step: String
}

struct StepItem: Decodable, Equatable {
    let id: Int
    let name: String
    let image: String
}
