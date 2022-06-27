//
//  CategoryViewController.swift
//  TodoListViewCode
//
//  Created by user on 27/06/22.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var categoryView: CategoryView? {
        return view as? CategoryView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        let categoryView = CategoryView()
        categoryView.setupView()
        categoryView.setupConstraints()
        categoryView.setupAdditional()
        isModalInPresentation = true
        view = categoryView
    }

}
