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
    }
    
    override func loadView() {
        let main = MainViewController()
        main.setupView()
        view = main
    }

}

