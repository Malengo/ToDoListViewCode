//
//  ItemOfCategoryViewController.swift
//  TodoListViewCode
//
//  Created by user on 27/06/22.
//
import CoreData
import UIKit

class ItemOfCategoryViewController: UIViewController {
    
    var itemManager = ItemModel()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedCategory: Category?{
        didSet{
            if let nameCategory = selectedCategory?.name {
                itemManager.typeCategory = nameCategory
                itemManager.getAll()
            }
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
        navigationItem.rightBarButtonItem = coreDataView?.configureBarButton(action: #selector(buttonAddCategoryPressed), target: self)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @objc private func buttonAddCategoryPressed() {
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
    
}
//MARK: -- tableView DataSource
extension ItemOfCategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemManager.getCount() == 0 ? 1 : itemManager.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if itemManager.isEmptyList() {
            cell.textLabel?.text = "There are no Items in the \(selectedCategory?.name ?? "ToDo") Category "
        } else {
            cell.textLabel?.text = itemManager.currentTextCell(indexPath: indexPath)
            cell.accessoryType = itemManager.isChecked(index: indexPath) ? .checkmark : .none
        }
        return cell
    }
}
//MARK: - TableView Delegate Methods
extension ItemOfCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if itemManager.isEmptyList() {
            coreDataView?.deselectRow(at: indexPath)
        } else {
            itemManager.updateIsChecked(index: indexPath)
            coreDataView?.reloadTableViewData()
            coreDataView?.deselectRow(at: indexPath)
        }
    }
}


//MARK: - Data Model
extension ItemOfCategoryViewController {
    func saveItem(itemName: String) {
        do {
            let item = Item(context: context)
            item.title = itemName
            item.parentCategory = selectedCategory
            try context.save()
            itemManager.addNewItem(item: item)
            coreDataView?.reloadTableViewData()
        } catch {
            let alertError = UIAlertController(title: "Error adding item", message: "", preferredStyle: .alert)
            alertError.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alertError, animated: true)
        }
    }
}

//MARK: SearchBar delegate
extension ItemOfCategoryViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let title = searchBar.text, !title.isEmpty {
            itemManager.searchByTitle(textSearch: title)
            coreDataView?.reloadTableViewData()
        } else {
            DispatchQueue.main.async {
                self.itemManager.getAll()
                self.coreDataView?.reloadTableViewData()
            }
        }
    }
}

// MARK: - CollectionView DataSource

extension ItemOfCategoryViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
}
