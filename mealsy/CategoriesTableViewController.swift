//
//  ViewController.swift
//  mealsy
//
//  Created by Frank Aceves on 1/24/22.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    let testCategory = Category(
        idCategory: "1",
        strCategory: "Beef",
        strCategoryThumb: "https://www.themealdb.com/images/category/beef.png",
        strCategoryDescription: "Beef is the culinary name for meat from cattle, particularly skeletal muscle. Humans have been eating beef since prehistoric times.[1] Beef is a source of high-quality protein and essential nutrients.[2]"
    )
    var categories: [Category] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        categories = [testCategory]
        navigationItem.title = "Categories"
    }
}

extension CategoriesTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = UITableViewCell()
        categoryCell.textLabel?.text = categories[indexPath.row].strCategory
        return categoryCell
    }
}

