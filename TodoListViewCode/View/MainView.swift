//
//  MainViewController.swift
//  TodoListViewCode
//
//  Created by user on 22/06/22.
//

import UIKit

class MainView: UIView {
    
    //MARK: -- components
    lazy var coreDataButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ToDo using CoreData", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    lazy var realmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ToDo using Realm", for: .normal)
        button.backgroundColor = .systemRed
        return button
    }()
    //MARK: -- Setup components
    func setupView() {
        backgroundColor = .white
        addSubview(coreDataButton)
    }
    
    func setupConstraints() {
        coreDataButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        coreDataButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        coreDataButton.translatesAutoresizingMaskIntoConstraints = false
    }
}
