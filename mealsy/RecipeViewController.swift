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
    @IBOutlet weak var recipeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        loadViews()
    }
    func loadViews() {
        recipeTableView.separatorStyle = .none
        guard let id = recipeID, let name = recipeName else {
            return
        }
        recipeHeaderLabel.text = "How To Make \(name)"
        recipeVM.fetchRecipe(id: id) { [unowned self] in
            DispatchQueue.main.async {
                recipeTableView.reloadData()
            }
        }
    }
    func setupDelegates() {
        recipeTableView.delegate = self
        recipeTableView.dataSource = self
    }
}
extension RecipeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Ingredients"
        case 1:
            return "Recipe Instructions"
        default:
            return nil
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return recipeVM.recipeToReturn?.ingredients.count ?? 0
        case 1:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            // these are ingredient cells
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeIngredientsTableViewCell") as? RecipeIngredientsTableViewCell else {
                return UITableViewCell()
            }
            guard let ingredient = recipeVM.recipeToReturn?.ingredients[indexPath.row] else {
                return UITableViewCell()
            }
            let ingredientString = recipeVM.constructedString(ingredient: ingredient)
            cell.ingredientsLabel.text = ingredientString
            return cell
        case 1:
            // this is an instruction cell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeInstructionsCell") as? RecipeInstructionsCell else {
                return UITableViewCell()
            }
            let recipeInstructions = recipeVM.recipeToReturn?.mealInstructions ?? ""
            cell.recipeInstructionLabel.text = recipeInstructions
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    
}
