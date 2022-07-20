//
//  ViewController.swift
//  TodoListViewCode
//
//  Created by user on 22/06/22.
//

import UIKit

class MainViewController: UIViewController {
    
    let defaults = UserDefaults.standard
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
        self.mainView?.firebaseButton.addTarget(self, action: #selector(fireBaseButtonPressed), for: .touchDown)
    }
    
    @objc func coreDataButtonPressed() {
        let coreDataTebleView = CategoryTableViewController()
        self.navigationController?.pushViewController(coreDataTebleView, animated: true)
    }
    
    @objc func realmButtonPressed() {
        let realmTableView = CategoryRealmViewController()
        self.navigationController?.pushViewController(realmTableView, animated: true)
    }
    
    @objc func fireBaseButtonPressed() {
        let fireBaseView = CategoryFireBaseViewController()
        self.navigationController?.pushViewController(fireBaseView, animated: true)
    }
    
    @objc func showAlert() {
        let alert = UIAlertController(title: "Do the Thing", message: "Let us know if you want to do the thing", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("...Cancel")
        }
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            print(".....OK")
        }
        
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        alert.preferredAction = okAction
        present(alert, animated: true)
    }
    
}


