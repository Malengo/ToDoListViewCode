//
//  CoreDataTableViewController.swift
//  TodoListViewCode
//
//  Created by user on 24/06/22.
//
import CoreData
import UIKit
import CoreData

class CoreDataTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var categories = [NSManagedObject]()
    var model = Model<Category>()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var coreDataView: DataTableView? {
        return view as? DataTableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setupNavigationBar()
        
        coreDataView?.tableView.delegate = self
        coreDataView?.tableView.dataSource = self
        
        categories = model.read()
        
    }
    
    override func loadView() {
        let tableView = DataTableView()
        tableView.setupView()
        tableView.setupConstraints()
        view = tableView
    }
    
    //MARK: - Configuration navigation
    func setupNavigationBar(){
        navigationItem.title = "Core Data"
        navigationItem.rightBarButtonItem = coreDataView?.barButton
        coreDataView?.barButton.action = #selector(addCategoryPressed)
        coreDataView?.barButton.target = self
        
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
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let category = categories[indexPath.row]
            model.delete(entity: category)
            categories.remove(at: indexPath.row)
            coreDataView?.tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}

extension CoreDataTableViewController {
    
    func saveCategory(categoryName: String) {
        do {
            let category = Category(context: self.context)
            category.name = categoryName
            try self.context.save()
            self.categories.append(category)
            self.coreDataView?.tableView.reloadData()
        } catch {
            let alertError = UIAlertController(title: "Error adding category", message: "", preferredStyle: .alert)
            alertError.addAction(UIAlertAction(title: "Ok", style: .default))
            self.present(alertError, animated: true)
        }
    }
}
