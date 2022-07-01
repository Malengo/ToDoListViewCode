//
//  SearchHistoryCell.swift
//  TodoListViewCode
//
//  Created by user on 30/06/22.
//

import UIKit

class SearchHistoryCell: UICollectionViewCell, ViewCodeProtocol {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Components Cell
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        return button
    }()
    
    private lazy var buttonAdd: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 4
        return stack
    }()
    
    // MARK: - View Code
    func buildViewHierachy() {
        addSubview(mainStack)
        mainStack.addArrangedSubview(buttonAdd)
        mainStack.addArrangedSubview(deleteButton)
    }
    
    func setupConstraints() {
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        mainStack.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18).isActive = true
        
        trailingAnchor.constraint(equalTo: mainStack.trailingAnchor).isActive = true
    }
    
    func addictionalConfiguration() {

    }
    
    // MARK: - public methods
       
    func configureTrashButton(action: Selector, target: AnyObject) {
        deleteButton.addTarget(target, action: action, for: .touchDown)
    }
    
    func setButtonTitle(title: String) {
        buttonAdd.setTitle(title, for: .normal)
    }
    
    func setIndexButton(index: Int) {
        deleteButton.tag = index
    }
}
