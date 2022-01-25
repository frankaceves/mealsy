//
//  ImageDownloader.swift
//  mealsy
//
//  Created by Frank Aceves on 1/24/22.
//

import Foundation
struct ImageDownloader {
    func downloadImage(from url: String, completion: @escaping (Bool, Data?) -> Void) {
        guard let url = URL(string: url) else {
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
            completion(true, data)
        }.resume()
    }
}
