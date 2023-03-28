//
//  MainViewController.swift
//  TodoListViewCode
//
//  Created by user on 22/06/22.
//

import UIKit

protocol MainViewProtocol: ViewCodeProtocol {
    func setupButtons(target: Any?, coredata: Selector, realm: Selector, firebase: Selector)
}

class MainView: UIView, MainViewProtocol {
    
    //MARK: -- View Components
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        return stackView
    }()
    
    //MARK: -- components
    lazy var coreDataButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ToDo using CoreData", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.accessibilityIdentifier = "CoreData"
        return button
    }()
    
    lazy var realmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ToDo using Realm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var firebaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ToDo using Firebase", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
    }()
    
    //MARK: -- Setup components
    func buildViewHierachy() {
        backgroundColor = .white
        addSubview(stackView)
        [coreDataButton, realmButton, firebaseButton].forEach { stackView.addArrangedSubview($0) }
    }
    
    func setupConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -10).isActive = true
        
        realmButton.translatesAutoresizingMaskIntoConstraints = false
        realmButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        realmButton.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        realmButton.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        
        coreDataButton.translatesAutoresizingMaskIntoConstraints = false
        coreDataButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        coreDataButton.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        coreDataButton.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
        
        firebaseButton.translatesAutoresizingMaskIntoConstraints = false
        firebaseButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        firebaseButton.leftAnchor.constraint(equalTo: stackView.leftAnchor).isActive = true
        firebaseButton.rightAnchor.constraint(equalTo: stackView.rightAnchor).isActive = true
    }
    
    func addictionalConfiguration() {
        
    }
    
    func setupButtons(target: Any?, coredata: Selector, realm: Selector, firebase: Selector) {
        coreDataButton.addTarget(target, action: coredata, for: .touchDown)
        realmButton.addTarget(target, action: realm, for: .touchDown)
        firebaseButton.addTarget(target, action: firebase, for: .touchDown)
    }
}
