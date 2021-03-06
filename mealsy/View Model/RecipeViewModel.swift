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
    case couldNotGetURLFromString
}

class RecipeViewModel {
    var recipeToReturn: RealRecipe?
    
    func fetchRecipe(id: String, completion: @escaping () -> Void) {
        downloadRecipeDetails(id: id) { [unowned self] unconstructedRecipe in
            switch unconstructedRecipe {
            case .success(let recipe):
                guard let recipeToReturn = constructRecipe(from: recipe.allMealItems) else {
                    completion()
                    return
                }
                self.recipeToReturn = recipeToReturn
                completion()
            case .failure:
                completion()
            }
        }
    }
    
    func downloadRecipeDetails(id: String, completion: @escaping (Result<RecipeItems,Error>) -> Void) {
        print(#function)
        let urlString = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        guard let url = URL(string: urlString) else {
            completion(.failure(RecipeDownloadError.couldNotGetURLFromString))
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
            guard let recipe = try? JSONDecoder().decode(RecipeItems.self, from: data) else {
                completion(.failure(RecipeDownloadError.couldNotParseJSON))
                return
            }
            //send completion, which then calls to construct recipe
            completion(.success(recipe))
        }.resume()
    }
    
    func constructRecipe(from dict: [[String:String?]]) -> RealRecipe? {
        print(#function)
        guard var recipeDict = dict.first else {
            return nil
        }
        //process name, instructions in dictionary
        guard let recipeName = recipeDict[RecipeConstants.recipeName.rawValue] as? String, let recipeInstructions = recipeDict[RecipeConstants.recipeInstructions.rawValue] as? String else {
            return nil
        }
        var recipeToReturn = RealRecipe(mealName: recipeName, mealInstructions: recipeInstructions, ingredients: [])
        //remove name, instructions
        recipeDict.removeValue(forKey: RecipeConstants.recipeName.rawValue)
        recipeDict.removeValue(forKey: RecipeConstants.recipeInstructions.rawValue)
        //construct recipe using remaining items
        recipeToReturn.ingredients = createIngredientArray(from: recipeDict)
        return recipeToReturn
    }
    
    func createIngredientArray(from dict: [String: String?]) -> [RealIngredient] {
        var filteredItems: [String: String] = [:]
        
        //filter out nil values
        let itemsWithNilFilteredOut = dict.filter { dict in
            dict.value != nil
        }
        //filter out empty values and spaces
        let itemsWithSpacesFilteredOut = itemsWithNilFilteredOut.filter { dict in
            !dict.value!.isEmpty && dict.value != " "
        }
        //remove all other items other than ingredient & measurement
        let filteredIngredientAndMeasurement = itemsWithSpacesFilteredOut.filter { item in
            item.key != RecipeConstants.recipeIngredientName.rawValue && item.key != RecipeConstants.recipeIngredientMeasurement.rawValue
        }
        var index = 1
        while index <= filteredIngredientAndMeasurement.count {
            if let name = filteredIngredientAndMeasurement[RecipeConstants.recipeIngredientName.rawValue + "\(index)"] as? String, let measure = filteredIngredientAndMeasurement[RecipeConstants.recipeIngredientMeasurement.rawValue + "\(index)"] as? String {
                filteredItems[name] = measure
            }
            index += 1
        }
        //call constructor func
        let array = constructRealIngredientArray(ingredientDict: filteredItems)
        return array
    }
    func constructRealIngredientArray(ingredientDict: [String: String]) -> [RealIngredient] {
        //take dicts and combine
        var constructedIngredientArray: [RealIngredient] = []
        ingredientDict.forEach { element in
            let name = element.key
            let measure = element.value
            let ingredient = RealIngredient(name: name, measurement: measure)
            constructedIngredientArray.append(ingredient)
        }
        return constructedIngredientArray
    }
    
    func constructedString(ingredient: RealIngredient) -> String {
        let constructedString = "\(ingredient.name): \(ingredient.measurement)"
        return constructedString
    }
}
