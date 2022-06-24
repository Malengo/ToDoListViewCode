//
//  CoreDateTableView.swift
//  TodoListViewCode
//
//  Created by user on 24/06/22.
//

import UIKit

class CoreDateTableView: UIView {
    //MARK : Components View
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.layer.cornerRadius = 8
        table.clipsToBounds =  true
        return table
    }()
    
    func setupView() {
        addSubview(tableView)
    }
    
    func setupConstraints(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -18).isActive = true
        tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 18).isActive = true
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    
}
