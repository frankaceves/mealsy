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
        recipeVM.downloadRecipe(id: id) { [unowned self] result in
            switch result {
            case .success(let recipe):
                DispatchQueue.main.async {
                    self.instructionsTextView.text = recipe.strInstructions
                    self.instructionsTextView.textContainer.lineFragmentPadding = 0
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
