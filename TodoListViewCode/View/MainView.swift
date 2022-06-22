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
        return button
    }()
    
    func setupView() {
        addSubview(coreDataButton)
    }
}
