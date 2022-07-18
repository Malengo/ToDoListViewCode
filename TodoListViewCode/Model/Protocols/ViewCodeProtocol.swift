//
//  ViewCodeProtocol.swift
//  TodoListViewCode
//
//  Created by user on 29/06/22.
//

import Foundation
import UIKit

protocol ViewCodeProtocol: UIView {
    func buildViewHierachy()
    func setupConstraints()
    func addictionalConfiguration()
}

extension ViewCodeProtocol {
    func setupView(){
        buildViewHierachy()
        setupConstraints()
        addictionalConfiguration()
    }
}
