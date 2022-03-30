//
//  RecipeViewController.swift
//  mealsy
//
//  Created by Frank Aceves on 3/30/22.
//

import UIKit
class RecipeViewController: UIViewController {
    var recipeID: String?
    var recipeName: String?
    
    @IBOutlet weak var recipeHeaderLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeHeaderLabel.text = "How To Make \(recipeName!)"
    }
}
