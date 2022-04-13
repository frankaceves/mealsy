//
//  Recipe.swift
//  mealsy
//
//  Created by Frank Aceves on 3/30/22.
//

import Foundation
struct RecipeItems: Decodable {
    let allMealItems: [[String: String?]]
    
    enum CodingKeys: String, CodingKey {
        case allMealItems = "meals"
    }
}
enum RecipeConstants: String {
    case recipeName = "strMeal"
    case recipeInstructions = "strInstructions"
    case ingredient = "strIngredient"
    case measurement = "strMeasure"
}
public struct RealIngredient {
    var name: String
    var measurement: String
}
public struct RealRecipe {
    var mealName: String
    var mealInstructions: String
    var ingredients: [RealIngredient]
}
