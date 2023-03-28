//
//  ViewController.swift
//  TodoListViewCode
//
//  Created by user on 22/06/22.
//

import UIKit

class MainViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    var mainView: MainViewProtocol = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
        navigationItem.title = "ToDo List with data"
    }
    
    override func loadView() {
        mainView.setupView()
        view = mainView
    }
    
    //MARK: Button Actions and settings
    
    func setupButtons() {
        mainView.setupButtons(
            target: self,
            coredata: #selector(coreDataButtonPressed),
            realm: #selector(realmButtonPressed),
            firebase: #selector(fireBaseButtonPressed)
        )
    }
    
    @objc func coreDataButtonPressed() {
        let coreDataTebleView = CategoryTableViewController()
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.pushViewController(coreDataTebleView, animated: true)
        }
    }
    
    @objc func realmButtonPressed() {
        let realmTableView = CategoryRealmViewController()
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.pushViewController(realmTableView, animated: true)
        }
    }
    
    @objc func fireBaseButtonPressed() {
        let fireBaseView = CategoryFireBaseViewController()
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.pushViewController(fireBaseView, animated: true)
        }
    }
    
}


