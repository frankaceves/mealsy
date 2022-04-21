//
//  Meal.swift
//  mealsy
//
//  Created by Frank Aceves on 3/30/22.
//

import Foundation
struct Meals: Decodable {
    let meals: [Meal]
}
struct Meal: Decodable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}
