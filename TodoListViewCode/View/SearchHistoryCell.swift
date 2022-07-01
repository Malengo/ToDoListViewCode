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
    
    private lazy var buttonDelete: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // MARK: - View Code
    func buildViewHierachy() {
        addSubview(buttonDelete)
    }
    
    func setupConstraints() {
        
        buttonDelete.translatesAutoresizingMaskIntoConstraints = false
        buttonDelete.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        buttonDelete.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 18).isActive = true
        
        trailingAnchor.constraint(equalTo: buttonDelete.trailingAnchor).isActive = true
    }
    
    func addictionalConfiguration() {
    }
    
    // MARK: - public methods
       
    func configureButtonTrash(action: Selector, target: AnyObject) {
        buttonDelete.addTarget(target, action: action, for: .touchDown)
    }
    
    func setButtonTitle(title: String) {
        buttonDelete.setTitle(title, for: .normal)
    }
}
