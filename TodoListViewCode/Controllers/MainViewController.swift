//
//  ViewController.swift
//  TodoListViewCode
//
//  Created by user on 22/06/22.
//

import UIKit

class MainViewController: UIViewController {
    
    var mainView: MainView? {
        return view as? MainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        navigationItem.title = "ToDo List with data"
    }
    
    override func loadView() {
        let main = MainView()
        main.setupView()
        main.setupConstraints()
        view = main
    }
    
    //MARK: Button Actions and settings
    
    func setupButtons(){
        self.mainView?.coreDataButton.addTarget(self, action: #selector(coreDataButtonPressed), for: .touchDown)
    }
    
    @objc func coreDataButtonPressed(){
        let coreDataTebleView = CoreDataTableViewController()
        self.navigationController?.pushViewController(coreDataTebleView, animated: true)
    }
    
}

