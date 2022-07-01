//
//  CategoryRealmViewController.swift
//  TodoListViewCode
//
//  Created by user on 28/06/22.
//

import UIKit
import RealmSwift

class CategoryRealmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var categories: Results<CategoryRealm>?
    private let categoryModel = ModelRealm<CategoryRealm>()
    
    private var coreDataView: DataTableView? {
        return view as? DataTableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        coreDataView?.setViewDelegateAndDataSource(to: self)
        categories = categoryModel.read()
    }
    
    override func loadView() {
        let tableView = DataTableView()
        tableView.setupView()
        view = tableView
    }
    
    //MARK: - SetUp navigation and View
    private func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "Realm Data"
        navigationItem.rightBarButtonItem = coreDataView?.configureBarButton(action: #selector(addCategoryPressed), target: self)
    }
    
    @objc private func addCategoryPressed() {
        let alertToAddCategory = UIAlertController(title: "Add new Category", message: nil, preferredStyle: .alert)
        alertToAddCategory.addTextField { textfieldNewCategory in
            textfieldNewCategory.placeholder = "Enter here for new Category"
        }
        
        let addActionCategory = UIAlertAction(title: "Add Category", style: .default) { _ in
            if let textFields = alertToAddCategory.textFields {
                if let newCategory = textFields.first?.text {
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
        coreDataView?.deselectRow(at: indexPath)
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
        coreDataView?.reloadTableViewData()
    }
}

//MARK: SearchBar Methods
extension CategoryRealmViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let name = searchBar.text, !name.isEmpty {
            categories = categories?.filter("name CONTAINS[cd] %@", name).sorted(byKeyPath: "name", ascending: true)
            coreDataView?.reloadTableViewData()
        } else {
            DispatchQueue.main.async {
                self.categories = self.categoryModel.read()
                self.coreDataView?.reloadTableViewData()
            }
        }
    }
    func updateSearchResults(for searchController: UISearchController) {
        if let name = searchController.searchBar.text, !name.isEmpty {
            categories = categories?.filter("name CONTAINS[cd] %@", name).sorted(byKeyPath: "name", ascending: true)
            coreDataView?.reloadTableViewData()
        } else {
            DispatchQueue.main.async {
                self.categories = self.categoryModel.read()
                self.coreDataView?.reloadTableViewData()
            }
        }
    }
}

// MARK: - CollectionView DataSource

extension CategoryRealmViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
}
