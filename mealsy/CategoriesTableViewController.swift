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
    var dessertViewModel = DessertViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.title = "Categories"
        callForCategories()
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
        //return viewModel.categories.count
        return dessertViewModel.desserts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dessertCell = UITableViewCell()
        dessertCell.textLabel?.text = dessertViewModel.desserts[indexPath.row].strMeal
        return dessertCell
    }
}

