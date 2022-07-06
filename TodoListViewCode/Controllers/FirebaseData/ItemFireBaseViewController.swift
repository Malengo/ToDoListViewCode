//
//  ItemFireBaseViewController.swift
//  TodoListViewCode
//
//  Created by user on 06/07/22.
//

import UIKit

class ItemFireBaseViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate, UITableViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SearchHistoryCell {
            return cell
        }
        fatalError("Unable to dequeue subclassed cell")
    }
    
    
    private var itemModel = ItemFireBaseModel()
    
    private var tableItem: DataTableView? {
        return view as? DataTableView
    }
    
    var selectedCategory: CategoryFireBase? {
        didSet {
            itemModel.fieldDb = selectedCategory!.name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableItem?.setViewDelegateAndDataSource(to: self)
        itemModel.delegate = self
        itemModel.getAll()
        setupNavigationBar()
    }
    
    override func loadView() {
        let table = DataTableView()
        table.setupView()
        view = table
    }
    
    //MARK: - SetUp navigation and View
    private func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = selectedCategory?.name
        navigationItem.rightBarButtonItem = tableItem?.configureBarButton(action: #selector(addCategoryPressed), target: self)
    }
    
    @objc private func addCategoryPressed() {
        let alertToAddCategory = UIAlertController(title: "Add new Item", message: nil, preferredStyle: .alert)
        alertToAddCategory.addTextField { textfieldNewCategory in
            textfieldNewCategory.placeholder = "Enter here for new Item"
        }
        
        let addActionCategory = UIAlertAction(title: "Add Item", style: .default) { _ in
            if let textFields = alertToAddCategory.textFields {
                if let newItem = textFields.first?.text {
                    self.saveItem(itemTitle: newItem)
                }
            }
        }
        alertToAddCategory.addAction(addActionCategory)
        alertToAddCategory.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        present(alertToAddCategory, animated: true)
    }

}

extension ItemFireBaseViewController {
    
    func saveItem(itemTitle: String) {
        do {
            let item = ItemFireBase(title: itemTitle)
            try itemModel.saveNewItem(item: item)
        } catch {
            let alertError = UIAlertController(title: "Error adding Item", message: "", preferredStyle: .alert)
            alertError.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alertError, animated: true)
        }
    }
}

// MARK: - TableView Datasource

extension ItemFireBaseViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemModel.getCount() == 0 ? 1 : itemModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = itemModel.getCount() == 0 ? "Update List....." : itemModel.getTextInTheCell(indexPath: indexPath)
        return cell
    }
}

// MARK: - Update Delegate

extension ItemFireBaseViewController: UpdateTableProtocol {
    func update() {
        self.tableItem?.reloadTableViewData()
    }
    
}
