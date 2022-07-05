//
//  CategoryFireBaseViewController.swift
//  TodoListViewCode
//
//  Created by user on 05/07/22.
//

import UIKit
import Firebase

class CategoryFireBaseViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SearchHistoryCell {
            return cell
        }
        fatalError("Unable to dequeue subclassed cell")
    }
    
    
    var categoryFireBaseModel = FireBaseModel()
    private var fireBaseTableView: DataTableView? {
        return view as? DataTableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fireBaseTableView?.setViewDelegateAndDataSource(to: self)
        categoryFireBaseModel.delegate = self
    }
    
    override func loadView() {
        let tableView = DataTableView()
        tableView.setupView()
        view = tableView
    }
}

// MARK: - TableView DataSource

extension CategoryFireBaseViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryFireBaseModel.getCount() == 0 ? 1 : categoryFireBaseModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = categoryFireBaseModel.getCount() == 0 ? "Update List....." : categoryFireBaseModel.getTextPosition(indexPath: indexPath)
        return cell
    }
    
    
}

// MARK: - TableView Delegate

extension CategoryFireBaseViewController: UITableViewDelegate {
    
}

// MARK: - Update Delegate

extension CategoryFireBaseViewController: UpdateTableProtocol {
    func update() {
            self.fireBaseTableView?.reloadTableViewData()
    }
    
}
