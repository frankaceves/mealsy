//
//  Category.swift
//  mealsy
//
//  Created by Frank Aceves on 1/24/22.
//

struct Categories: Decodable {
    let categories: [Category]
}
struct Category: Decodable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}

