//
//  CoreDateTableView.swift
//  TodoListViewCode
//
//  Created by user on 24/06/22.
//

import UIKit

class DataTableView: UIView, ViewCodeProtocol {
    
    //MARK : Components View
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.layer.cornerRadius = 8
        table.clipsToBounds =  true
        return table
    }()
    
    private lazy var barButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.image = UIImage(systemName: "plus.circle")
        return button
    }()
    
    private lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Search......"
        return search
    }()
    
    // MARK: - View Code
    
    func buildViewHierachy() {
        addSubview(searchBar)
        addSubview(tableView)
    }
    
    func setupConstraints(){
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        searchBar.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -18).isActive = true
        tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 18).isActive = true
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 18).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    func addictionalConfiguration() {
        backgroundColor = .systemGray5
        searchBar.searchBarStyle = .minimal
    }
    
    // MARK: - Public Methods
    
    func setViewDelegateAndDataSource(to delegate: UITableViewDelegate & UITableViewDataSource & UISearchBarDelegate) {
        tableView.delegate = delegate
        tableView.dataSource = delegate
        searchBar.delegate = delegate
    }
    
    @discardableResult
    func configureBarButton(action: Selector, target: AnyObject) -> UIBarButtonItem {
        barButton.action = action
        barButton.target = target
        return barButton
    }
    
    func deselectRow(at index: IndexPath, animated: Bool = true) {
        tableView.deselectRow(at: index, animated: animated)
    }
    
    func reloadTableViewData() {
        tableView.reloadData()
    }
}
