//
//  RecipeViewModel.swift
//  mealsy
//
//  Created by Frank Aceves on 3/30/22.
//

import Foundation

enum RecipeDownloadError: Error {
    case errorFromDataTask
    case dataTaskResponseNot200
    case dataTaskNoDataReturned
    case couldNotParseJSON
}

class RecipeViewModel {
    
    func downloadRecipe(id: String, completion: @escaping (Result<Recipe,Error>) -> Void) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        guard let url = URL(string: urlString) else {
            print("can't get recipe url from string")
            return
        }
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(RecipeDownloadError.errorFromDataTask))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode >= 200 else {
                completion(.failure(RecipeDownloadError.dataTaskResponseNot200))
                return
            }
            guard let data = data else {
                completion(.failure(RecipeDownloadError.dataTaskNoDataReturned))
                return
            }
            guard let recipes = try? JSONDecoder().decode(Recipes.self, from: data) else {
                print("could not decode RECIPES JSON")
                completion(.failure(RecipeDownloadError.couldNotParseJSON))
                return
            }
            completion(.success(recipes.meals[0]))
        }.resume()
    }
}
