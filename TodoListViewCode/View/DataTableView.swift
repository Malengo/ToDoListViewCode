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
    
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .systemGray5
        collection.clipsToBounds = true
        collection.layer.cornerRadius = 8
        collection.register(SearchHistoryCell.self, forCellWithReuseIdentifier: "cell")
        return collection
    }()
    
    private lazy var searchLabel: UILabel = {
        let label = UILabel()
        label.text = "Search History"
        return label
    }()
    
    private lazy var searchStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.isHidden = true
        return stack
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 9
        return stack
    }()
    
    // MARK: - View Code
    
    func buildViewHierachy() {
        addSubview(searchBar)
        addSubview(mainStack)
        mainStack.addArrangedSubview(searchStack)
        mainStack.addArrangedSubview(tableView)
        searchStack.addArrangedSubview(searchLabel)
        searchStack.addArrangedSubview(collection)
    }
    
    func setupConstraints(){
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        searchBar.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        searchStack.translatesAutoresizingMaskIntoConstraints = false
        searchStack.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -18).isActive = true
        mainStack.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 18).isActive = true
        mainStack.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    func addictionalConfiguration() {
        backgroundColor = .systemGray5
        searchBar.searchBarStyle = .minimal
    }
    
    // MARK: - Public Methods
    
    func setViewDelegateAndDataSource(to delegate: UITableViewDelegate & UITableViewDataSource & UISearchBarDelegate & UICollectionViewDelegate & UICollectionViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = delegate
        searchBar.delegate = delegate
        collection.delegate = delegate
        collection.dataSource = delegate
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
    
    func reloadCollectionViewData() {
        collection.reloadData()
    }
    
    func hideSearchHistory() {
        searchStack.isHidden = true
        searchBar.showsCancelButton = false
        reloadInputViews()
    }
    
    func showSearchHistory() {
        searchBar.showsCancelButton = true
        searchStack.isHidden = false
        reloadInputViews()
    }
    
    func setTextSearchBar(text: String) {
        searchBar.text = text
    }
}
