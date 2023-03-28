//
//  ItemRealmViewController.swift
//  TodoListViewCode
//
//  Created by user on 28/06/22.
//

import UIKit
import RealmSwift

class ItemRealmViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var items: Results<ItemRealm>?
    var itemManager = ModelRealm<ItemRealm>()
    let realm = try? Realm()
   
    var selectedCategory: CategoryRealm? {
        didSet {
            items = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
            navigationItem.title = selectedCategory?.name
        }
    }
    
    var coreDataView: DataTableView? {
        return view as? DataTableView
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataView?.setViewDelegateAndDataSource(to: self)
        setupNavigationBar()
    }
    
    override func loadView() {
        let tableView = DataTableView()
        tableView.setupView()
        view = tableView
    }
    
    //MARK: - Configuration navigation
    private func setupNavigationBar(){
        navigationItem.title = selectedCategory?.name
        navigationItem.rightBarButtonItem = coreDataView?.configureBarButton(action: #selector(buttonAddPressed), target: self)
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    @objc private func buttonAddPressed() {
        let alertToAddItem = UIAlertController(title: "Add new Item", message: nil, preferredStyle: .alert)
        alertToAddItem.addTextField { textfieldNewCategory in
            textfieldNewCategory.placeholder = "Enter here for new Item"
        }
        
        let addActionCategory = UIAlertAction(title: "Add Item", style: .default) { _ in
            if let textFields = alertToAddItem.textFields {
                if let newItem = textFields.first?.text {
                    self.saveItem(itemName: newItem)
                }
            }
            
        }
        
        alertToAddItem.addAction(addActionCategory)
        alertToAddItem.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        present(alertToAddItem, animated: true)
    }
    
    
    //MARK: -- tableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if let item = items?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } 
        return cell
    }
    
    //MARK - TableView Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = items?[indexPath.row]{
            try? realm?.write({
                item.done = !item.done
            })
            coreDataView?.reloadTableViewData()
        }
    }
}

//MARK: Data Model
extension ItemRealmViewController {
    
    func saveItem(itemName: String) {
        do {
            try realm?.write {
                let item = ItemRealm()
                item.title = itemName
                selectedCategory?.items.append(item)
                coreDataView?.reloadTableViewData()
            }
        } catch {
            let alertError = UIAlertController(title: "Error adding item", message: "", preferredStyle: .alert)
            alertError.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alertError, animated: true)
        }
    }
}

//MARK: SearchBar delegate
extension ItemRealmViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let title = searchBar.text, !title.isEmpty {
            items = items?.filter("title CONTAINS[cd] %@", title).sorted(byKeyPath: "title", ascending: true)
            coreDataView?.reloadTableViewData()
        } else {
            DispatchQueue.main.async {
                self.items = self.selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
                self.coreDataView?.reloadTableViewData()
            }
        }
    }
}

// MARK: - CollectionView DataSource

extension ItemRealmViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
}
