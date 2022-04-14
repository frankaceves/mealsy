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
    var recipeVM = RecipeViewModel()
    @IBOutlet weak var recipeHeaderLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var instructionsTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViews()
    }
    func loadViews() {
        guard let id = recipeID, let name = recipeName else {
            return
        }
        recipeHeaderLabel.text = "How To Make \(name)"
        recipeVM.fetchRecipe(id: id) { [unowned self] in
            DispatchQueue.main.async {
                self.instructionsTextView.text = recipeVM.recipeToReturn?.mealInstructions
                self.instructionsTextView.textContainer.lineFragmentPadding = 0
                // TODO: add full ingredients list (possibly to tableView)
                self.ingredientsLabel.text = recipeVM.recipeToReturn?.ingredients[0].name
            }
        }
    }
}
