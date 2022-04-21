//
//  ViewController.swift
//  mealsy
//
//  Created by Frank Aceves on 1/24/22.
//

import UIKit

class DessertsTableViewController: UITableViewController {
    var dessertViewModel = DessertViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Desserts"
        getDesserts()
    }
    func getDesserts() {
        dessertViewModel.getDesserts { [unowned self] success in
            guard success else {
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension DessertsTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dessertViewModel.desserts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dessertCell = tableView.dequeueReusableCell(withIdentifier: "DessertsTableViewCell") as? DessertsTableViewCell else {
            return UITableViewCell()
        }
        let name = dessertViewModel.desserts[indexPath.row].strMeal
        let imageURLString = dessertViewModel.desserts[indexPath.row].strMealThumb
        
        dessertCell.configureCell(name: name, imageUrlString: imageURLString)
        return dessertCell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meal = dessertViewModel.desserts[indexPath.row]
        let mealID = meal.idMeal
        let mealName = meal.strMeal
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "RecipeViewController") as? RecipeViewController else {
            return
        }
        vc.recipeID = mealID
        vc.recipeName = mealName
        show(vc, sender: nil)
    }
}

