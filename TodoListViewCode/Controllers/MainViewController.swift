//
//  ViewController.swift
//  TodoListViewCode
//
//  Created by user on 22/06/22.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "ToDo List with data"
    }
    
    override func loadView() {
        let main = MainView()
        main.setupView()
        main.setupConstraints()
        view = main
    }

}

