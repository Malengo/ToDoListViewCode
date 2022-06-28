//
//  CategoryRealmViewController.swift
//  TodoListViewCode
//
//  Created by user on 28/06/22.
//

import UIKit
import RealmSwift

class CategoryRealmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var categories: Results<CategoryRealm>?
    let categoryModel = ModelRealm<CategoryRealm>()
    
    var coreDataView: DataTableView? {
        return view as? DataTableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
        
        coreDataView?.tableView.delegate = self
        coreDataView?.tableView.dataSource = self
        
        categories = categoryModel.read()
    }
    
    override func loadView() {
        let tableView = DataTableView()
        tableView.setupView()
        tableView.setupConstraints()
        tableView.searchBar.searchResultsUpdater = self
        view = tableView
    }
    
    //MARK: - SetUp navigation and View
    func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = coreDataView?.searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "Realm Data"
        navigationItem.rightBarButtonItem = coreDataView?.barButton
        
        coreDataView?.barButton.action = #selector(addCategoryPressed)
        coreDataView?.barButton.target = self
    }
    
    func setupView() {
        view.backgroundColor = .systemGray5
    }
    
    @objc func addCategoryPressed() {
        let alertToAddCategory = UIAlertController(title: "Add new Category", message: nil, preferredStyle: .alert)
        alertToAddCategory.addTextField { textfieldNewCategory in
            textfieldNewCategory.placeholder = "Enter here for new Category"
        }
        
        let addActionCategory = UIAlertAction(title: "Add Category", style: .default) { _ in
            if let textFields = alertToAddCategory.textFields {
                if let newCategory = textFields[0].text {
                    self.saveCategory(categoryName: newCategory)
                }
            }
            
        }
        
        alertToAddCategory.addAction(addActionCategory)
        alertToAddCategory.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        present(alertToAddCategory, animated: true)
    }
    
    // MARK: - TableView data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let category = categories?[indexPath.row]
        cell.textLabel?.text = category?.name ?? "there are no categoreis in the list"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ItemRealmViewController()
        let category = categories?[indexPath.row]
        vc.selectedCategory = category
        navigationController?.pushViewController(vc, animated: true)
        coreDataView?.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if let item = categories?[indexPath.row]{
                categoryModel.delete(entity: item)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

//MARK: Data Methods
extension CategoryRealmViewController {
    
    func saveCategory(categoryName: String) {
        let category = CategoryRealm()
        category.name = categoryName
        categoryModel.create(entity: category)
        coreDataView?.tableView.reloadData()
    }
}

//MARK: SearchBar Methods
extension CategoryRealmViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let name = searchController.searchBar.text {
            if name != "" {
                categories = categories?.filter("name CONTAINS[cd] %@", name).sorted(byKeyPath: "name", ascending: true)
                coreDataView?.tableView.reloadData()
            } else {
                DispatchQueue.main.async {
                    self.categories = self.categoryModel.read()
                    self.coreDataView?.tableView.reloadData()
                }
            }
        }
    }
}
