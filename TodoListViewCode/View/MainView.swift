//
//  MainViewController.swift
//  TodoListViewCode
//
//  Created by user on 22/06/22.
//

import UIKit

class MainView: UIView {
    
    lazy var coreDataButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ToDo using CoreData", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
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
