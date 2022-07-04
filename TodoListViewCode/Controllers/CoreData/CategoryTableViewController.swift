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
    var searchData = SearchHistoryData()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var width: CGFloat = 0.0
    
    var coreDataView: DataTableView? {
        return view as? DataTableView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        coreDataView?.setViewDelegateAndDataSource(to: self)
        categories = categoryModel.read()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        coreDataView?.hideSearchHistory()
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

// MARK: - Buttons action
extension CategoryTableViewController {
    
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
    
    @objc func deleteItemSearch(_ sender: UIButton) {
        let index = sender.tag 
        searchData.deleteWord(index: index)
        DispatchQueue.main.async {
            self.coreDataView?.reloadCollectionViewData()
        }
        if self.searchData.getWordsCount() == 0 {
            self.coreDataView?.hideSearchHistory()
        }
    }
    
    @objc func getWordForSearch(_ sender: UIButton) {
        guard let text = sender.titleLabel?.text else { return }
        coreDataView?.setTextSearchBar(text: text)
    }
}
// MARK: Data Methods

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
            searchData.saveData(word: name)
            coreDataView?.showSearchHistory()
            self.coreDataView?.reloadTableViewData()
            self.coreDataView?.reloadCollectionViewData()
        } else {
            DispatchQueue.main.async {
                self.categories = self.categoryModel.read()
                self.coreDataView?.reloadTableViewData()
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchData.getWordsCount() != 0 else { return }
        if let name = searchBar.text, !name.isEmpty {
            coreDataView?.showSearchHistory()
        } else {
            DispatchQueue.main.async {
                self.categories = self.categoryModel.read()
                self.coreDataView?.reloadTableViewData()
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        guard searchData.getWordsCount() != 0 else { return }
        if let name = searchBar.text, !name.isEmpty{
            coreDataView?.showSearchHistory()
        } else {
            coreDataView?.hideSearchHistory()
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        coreDataView?.hideSearchHistory()
        DispatchQueue.main.async {
            searchBar.text = ""
            self.categories = self.categoryModel.read()
            self.coreDataView?.reloadTableViewData()
        }
    }
}

// MARK: - CollectionView DataSource

extension CategoryTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchData.getWordsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SearchHistoryCell {
            cell.setButtonTitle(title: searchData.getWord(index: indexPath.row))
            cell.setIndexButton(index: indexPath.row)
            cell.configureTrashButton(action: #selector(deleteItemSearch(_ :)), target: self)
            cell.configureAddButton(action: #selector(getWordForSearch(_ :)), target: self)
        return cell
        }
        fatalError("Unable to dequeue subclassed cell")
    }
}
