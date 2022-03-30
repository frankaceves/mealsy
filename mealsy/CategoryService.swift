//
//  CategoryService.swift
//  mealsy
//
//  Created by Frank Aceves on 2/9/22.
//

import Foundation
struct CategoryService {
    func downloadCategories(completion: @escaping (Bool, Categories?) -> Void) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/categories.php"
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
            guard let categories = try? JSONDecoder().decode(Categories.self, from: data) else {
                print("could not decode category JSON")
                return
            }
            //print(categories.categories.count)
            completion(true, categories)
        }.resume()
    }
}
