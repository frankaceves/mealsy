//
//  RecipeViewModel.swift
//  mealsy
//
//  Created by Frank Aceves on 3/30/22.
//

import Foundation
class RecipeViewModel {
    var recipes: [Recipe] = []
    
    func downloadRecipe(id: String, completion: @escaping (Bool, Recipe?) -> Void) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        guard let url = URL(string: urlString) else {
            print("can't get url from string")
            return
        }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = URLRequest(url: url)
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 else {
                return
            }
            guard let data = data else {
                completion(false, nil)
                return
            }
            guard let recipes = try? JSONDecoder().decode(Recipes.self, from: data) else {
                print("could not decode RECIPES JSON")
                completion(false, nil)
                return
            }
            //print("RECIPES Count: \(recipes.meals.count)")
            //print("Recipe: \(recipes.meals[0].strMeal)")
            completion(true, recipes.meals[0])
        }.resume()
    }
}
