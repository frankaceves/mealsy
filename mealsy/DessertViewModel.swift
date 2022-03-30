//
//  DessertViewModel.swift
//  mealsy
//
//  Created by Frank Aceves on 3/30/22.
//

import Foundation
class DessertViewModel {
    var desserts: [Meal] = []
    
    func getDesserts(completion: @escaping (Bool) -> Void)  {
        print("dessert viewmodel: \(#function)")
        //self.view = view
        DessertService().downloadDessertMeals { [unowned self] success, meals in
            guard success else {
                completion(false)
                return
            }
            guard let desserts = meals?.meals else {
                completion(false)
                return
            }
            self.desserts = desserts
            completion(true)
        }
    }
}
