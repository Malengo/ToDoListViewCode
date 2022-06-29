//
//  ItemOfCategoryViewController.swift
//  TodoListViewCode
//
//  Created by user on 27/06/22.
//
import CoreData
import UIKit

class ItemOfCategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var items = [NSManagedObject]()
    var itemManager = ItemModel()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedCategory: Category?{
        didSet{
            itemManager.typeCategory = (selectedCategory?.name)!
            items = itemManager.listingItemByCategory()
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
        navigationItem.rightBarButtonItem = coreDataView?.configureBarButton(action: #selector(addCategoryPressed), target: self)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @objc private func addCategoryPressed() {
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
        let count = items.isEmpty ? 1  : items.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if items.isEmpty {
            cell.textLabel?.text = "There are no Items in the \(selectedCategory?.name ?? "ToDo") Category "
        } else {
            if let item = items[indexPath.row] as? Item {
                cell.textLabel?.text = item.title
                cell.accessoryType = item.isChecked ? .checkmark : .none
            }
        }
        return cell
    }
    
    //MARK - TableView Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if items.isEmpty {
            coreDataView?.deselectRow(at: indexPath)
        } else {
            if let item = items[indexPath.row] as? Item {
                item.isChecked = !item.isChecked
                itemManager.save()
                coreDataView?.reloadTableViewData()
                coreDataView?.deselectRow(at: indexPath)
            }
        }
    }
}

    //MARK: Data Model
extension ItemOfCategoryViewController {
    func saveItem(itemName: String) {
        do {
            let item = Item(context: context)
            item.title = itemName
            item.parentCategory = selectedCategory
            try context.save()
            items.append(item)
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
            items = self.itemManager.searchByTitle(textSearch: title)
            coreDataView?.reloadTableViewData()
        } else {
            DispatchQueue.main.async {
                self.items = self.itemManager.listingItemByCategory()
                self.coreDataView?.reloadTableViewData()
            }
        }
    }
}
