//
//  CoreDataTableViewController.swift
//  TodoListViewCode
//
//  Created by user on 24/06/22.
//
import UIKit
import CoreData

class CategoryTableViewController: UIViewController {
    
    var categoryModel: CRUDModelProtocol = CategoryModel()
    var searchData: CRUDSearchHistoryProtocol = SearchHistoryData(keyWord: Constants.keyWordSearchUserDefauts)
    var coreDataView: DataTableViewProtocol = DataTableView()
    var alert = UIAlertController(title: "Add New Category", message: nil, preferredStyle: .alert)
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAlert()
        categoryModel.delegate = self
        coreDataView.setViewDelegateAndDataSource(to: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    override func loadView() {
        coreDataView.setupView()
        view = coreDataView
    }
    
    //MARK: - SetUp navigation and View
    private func setupNavigationBar(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "Core Data"
        navigationItem.rightBarButtonItem = coreDataView.configureBarButton(action: #selector(buttonAddPressed), target: self)
    }
}
// MARK: - TableView data source

extension CategoryTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryModel.getCount() == 0 ? 1 : categoryModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = categoryModel.getCount() == 0 ? "There are no Items in the Category List" : categoryModel.currentTextCell(indexPath: indexPath)
        return cell
    }
}

// MARK: - TableView Delegate

extension CategoryTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if categoryModel.isEmptyList() {
            coreDataView.deselectRow(at: indexPath, animated: true)
        } else {
            let vc = ItemOfCategoryViewController()
            let category = categoryModel.getEntity(indexPath: indexPath)
            vc.selectedCategory = category as? Category
            navigationController?.pushViewController(vc, animated: true)
            coreDataView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            categoryModel.deleteTableItem(indexPath: indexPath)
        }
    }
}

// MARK: - Buttons action
extension CategoryTableViewController {
    
    private func configureAlert() {
        
        alert.addTextField { categoryTextField in
            categoryTextField.placeholder = "Enter here for new Item"
        }
        
        let action1 = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let newCategory = self?.alert.textFields?.first?.text else { return }
            self?.categoryModel.saveData(data: newCategory)
        }
        
        let action2 = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(action1)
        alert.addAction(action2)
    }
    
    @objc private func buttonAddPressed() {
        present(alert, animated: true)
    }
    
    @objc private func deleteItemSearch(_ sender: UIButton) {
        let index = sender.tag
        searchData.deleteWord(index: index)
        DispatchQueue.main.async { [weak self] in
            self?.coreDataView.reloadCollectionViewData()
        }
        if self.searchData.getCount() == 0 {
            self.coreDataView.hideSearchHistory()
        }
    }
    
    @objc private func getWordForSearch(_ sender: UIButton) {
        guard let text = sender.titleLabel?.text else { return }
        coreDataView.setTextSearchBar(text: text)
    }
}

//MARK: - SearchBar Methods

extension CategoryTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let name = searchBar.text, !name.isEmpty {
            //categoryModel.searchByName(name: name)
            searchData.saveData(word: name)
            self.coreDataView.reloadTableViewData()
            self.coreDataView.reloadCollectionViewData()
        } else {
            self.categoryModel.getAll()
            self.coreDataView.reloadTableViewData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchData.getCount() != 0 else { return }
        if let name = searchBar.text, !name.isEmpty {
            coreDataView.showSearchHistory()
        } else {
            coreDataView.hideSearchHistory()
            self.categoryModel.getAll()
            self.coreDataView.reloadTableViewData()
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        guard searchData.getCount() != 0 else { return }
        if let name = searchBar.text, !name.isEmpty {
            coreDataView.showSearchHistory()
        } else {
            coreDataView.hideSearchHistory()
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        coreDataView.hideSearchHistory()
        DispatchQueue.main.async { [weak self] in
            searchBar.text = ""
            self?.coreDataView.reloadTableViewData()
        }
    }
}

// MARK: - CollectionView DataSource

extension CategoryTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchData.getCount()
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

// MARK: - Update Protocol
extension CategoryTableViewController: UpdateTableProtocol {
    func update() {
        self.coreDataView.reloadTableViewData()
    }
}
