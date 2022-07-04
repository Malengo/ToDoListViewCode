//
//  ViewController.swift
//  TodoListViewCode
//
//  Created by user on 22/06/22.
//

import UIKit

class MainViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    var words: [String] = []
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
    
    func setupButtons() {
        self.mainView?.coreDataButton.addTarget(self, action: #selector(coreDataButtonPressed), for: .touchDown)
        self.mainView?.realmButton.addTarget(self, action: #selector(realmButtonPressed), for: .touchDown)
    }
    
    @objc func coreDataButtonPressed() {
        let coreDataTebleView = CategoryTableViewController()
        self.navigationController?.pushViewController(coreDataTebleView, animated: true)
    }
    
    @objc func realmButtonPressed() {
        let realmTableView = CategoryRealmViewController()
        self.navigationController?.pushViewController(realmTableView, animated: true)
    }
    
}


