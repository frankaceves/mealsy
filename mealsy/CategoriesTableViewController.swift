//
//  ViewController.swift
//  mealsy
//
//  Created by Frank Aceves on 1/24/22.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    var categories: [Category] = []
    var viewModel = CategoryViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Categories"
        callForCategories()
    }
    
    func callForCategories() {
        viewModel.getCategories { [weak self] success in
            guard success else {
                return
            }
            DispatchQueue.main.async {
                guard let tableView = self?.tableView else {
                    return
                }
                tableView.reloadData()
            }
        }
    }
}

extension CategoriesTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("viewmodel count: \(viewModel.categories.count)")
        return viewModel.categories.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let categoryCell = UITableViewCell()
        categoryCell.textLabel?.text = viewModel.categories[indexPath.row].strCategory
        return categoryCell
    }
}

