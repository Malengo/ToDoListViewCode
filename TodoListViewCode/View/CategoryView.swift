//
//  CreateCategory.swift
//  TodoListViewCode
//
//  Created by user on 27/06/22.
//

import UIKit

class CategoryView: UIView {
    
    
    //MARK: View Components
    lazy var stackViewLabel: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    lazy var stackViewButtons: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()
    
    lazy var mainStackView: UIStackView = {
        let stack  = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 20
        return stack
    }()
    
    lazy var viewBottom: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    //MARK: - Components
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create new Category"
        label.textAlignment = .center
        label.font = label.font.withSize(30)
        return label
    }()
    
    lazy var categoryTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter here for new Category "
        textField.backgroundColor = .systemGray5
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    lazy var buttonAdd: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = 5
        return button
    }()
    
    lazy var buttonCancel: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 5
        return button
    }()
    
    //MARK: SetupViews
    func setupView() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(stackViewLabel)
        mainStackView.addArrangedSubview(stackViewButtons)
        mainStackView.addArrangedSubview(viewBottom)
        
        stackViewButtons.addArrangedSubview(buttonAdd)
        stackViewButtons.addArrangedSubview(buttonCancel)
        
        stackViewLabel.addArrangedSubview(titleLabel)
        stackViewLabel.addArrangedSubview(categoryTextField)
        
    }
    
    func setupConstraints() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        mainStackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        mainStackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        
        stackViewLabel.translatesAutoresizingMaskIntoConstraints = false
        stackViewLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        stackViewButtons.translatesAutoresizingMaskIntoConstraints = false
        stackViewButtons.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    func setupAdditional(){
        backgroundColor = .white
    }
}
