//
//  CoreDataTableViewController.swift
//  TodoListViewCode
//
//  Created by user on 24/06/22.
//
import UIKit
import CoreData

protocol SaveWordProtocol: AnyObject {
    func saveSearch(word: String)
}

class CategoryTableViewController: UIViewController {
    
    var categories = [NSManagedObject]()
    let categoryModel = CategoryModel()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var delegate: SaveWordProtocol?
    
    var coreDataView: DataTableView? {
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
        navigationItem.title = "Core Data"
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
}
    // MARK: - TableView data source
extension CategoryTableViewController: UITableViewDataSource {
      
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = categories.isEmpty ? 1  : categories.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if categories.isEmpty {
            cell.textLabel?.text = "There are no Items in the Category List"
        } else {
            let category = categories[indexPath.row] as? Category
            cell.textLabel?.text = category?.name
        }
        return cell
    }    
}

// MARK: - TableView Delegate

extension CategoryTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if categories.isEmpty {
            coreDataView?.deselectRow(at: indexPath)
        } else {
            let vc = ItemOfCategoryViewController ()
            let category = categories[indexPath.row] as? Category
            vc.selectedCategory = category
            navigationController?.pushViewController(vc, animated: true)
            coreDataView?.deselectRow(at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let category = categories[indexPath.row]
            categoryModel.delete(entity: category)
            categories.remove(at: indexPath.row)
            coreDataView?.reloadTableViewData()
        }
    }
}

//MARK: Data Methods

extension CategoryTableViewController {
    
    func saveCategory(categoryName: String) {
        do {
            let category = Category(context: self.context)
            category.name = categoryName
            try self.context.save()
            self.categories.append(category)
            self.coreDataView?.reloadTableViewData()
        } catch {
            let alertError = UIAlertController(title: "Error adding category", message: "", preferredStyle: .alert)
            alertError.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alertError, animated: true)
        }
    }
}

//MARK: SearchBar Methods

extension CategoryTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let name = searchBar.text, !name.isEmpty {
            categories = categoryModel.searchByName(name: name)
            delegate?.saveSearch(word: name)
            self.coreDataView?.reloadTableViewData()
        } else {
            DispatchQueue.main.async {
                self.categories = self.categoryModel.read()
                self.coreDataView?.reloadTableViewData()
            }
        }
    }
}
