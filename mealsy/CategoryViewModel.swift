//
//  CategoryViewModel.swift
//  mealsy
//
//  Created by Frank Aceves on 2/9/22.
//

import Foundation
class CategoryViewModel {
    //var view: UIViewController
    var categories: [Category] = []
    
    func getCategories(completion: @escaping (Bool) -> Void)  {
        print("cat viewmodel: \(#function)")
        //self.view = view
        CategoryService().downloadCategories { success, categories in
            guard success else {
                completion(false)
                return
            }
            guard let categories = categories?.categories else {
                completion(false)
                return
            }
            self.categories = categories
            //call update
            completion(true)
        }
    }
    
    
}
