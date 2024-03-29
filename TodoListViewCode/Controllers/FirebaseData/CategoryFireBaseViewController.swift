//
//  CategoryFireBaseViewController.swift
//  TodoListViewCode
//
//  Created by user on 05/07/22.
//

import UIKit
import Firebase

class CategoryFireBaseViewController: UIViewController {
    
    
    var categoryFireBaseModel = CategoryFireBaseModel()
    
    private var fireBaseTableView: DataTableView? {
        return view as? DataTableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fireBaseTableView?.setViewDelegateAndDataSource(to: self)
        setupNavigationBar()
        categoryFireBaseModel.delegate = self
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
        navigationItem.title = "FireBase"
        navigationItem.rightBarButtonItem = fireBaseTableView?.configureBarButton(action: #selector(buttonAddPressed), target: self)
    }
    
    @objc private func buttonAddPressed() {
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
}

extension CategoryFireBaseViewController {
    
    func saveCategory(categoryName: String) {
        do {
            let category = CategoryFireBase(name: categoryName)
            try categoryFireBaseModel.addItem(categoty: category)
        } catch {
            let alertError = UIAlertController(title: "Error adding category", message: "", preferredStyle: .alert)
            alertError.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alertError, animated: true)
        }
    }
}

// MARK: - TableView DataSource

extension CategoryFireBaseViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryFireBaseModel.getCount() == 0 ? 1 : categoryFireBaseModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = categoryFireBaseModel.getCount() == 0 ? "Update List....." : categoryFireBaseModel.currentTextCell(indexPath: indexPath)
        return cell
    }
    
    
}

// MARK: - TableView Delegate

extension CategoryFireBaseViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete, !categoryFireBaseModel.isEmptyList() {
            categoryFireBaseModel.deleteTableItem(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ItemFireBaseViewController()
        vc.selectedCategory = categoryFireBaseModel.getOneCategory(indexPath: indexPath)
        self.navigationController?.pushViewController(vc, animated: true)
        self.fireBaseTableView?.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Update Delegate

extension CategoryFireBaseViewController: UpdateTableProtocol {
    func update() {
        self.fireBaseTableView?.reloadTableViewData()
    }
}

// MARK: - CollectioView datasource

extension CategoryFireBaseViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SearchHistoryCell {
            return cell
        }
        fatalError("Unable to dequeue subclassed cell")
    }
}

// MARK: - CollectionView Delegate

extension CategoryFireBaseViewController: UICollectionViewDelegate {
    
}

// MARK: - SearchBarDelegate

extension CategoryFireBaseViewController: UISearchBarDelegate {
    
}
