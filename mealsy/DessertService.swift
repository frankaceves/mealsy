//
//  DessertService.swift
//  mealsy
//
//  Created by Frank Aceves on 3/30/22.
//

import Foundation
struct DessertService {
    func downloadDessertMeals(completion: @escaping (Bool, Meals?) -> Void) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert"
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
                return
            }
            guard let meals = try? JSONDecoder().decode(Meals.self, from: data) else {
                print("could not decode MEALS JSON")
                return
            }
            print("Meals Count: \(meals.meals.count)")
            completion(true, meals)
        }.resume()
    }
}
