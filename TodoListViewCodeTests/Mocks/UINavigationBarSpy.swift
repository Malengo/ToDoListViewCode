//
//  UINavigationBarSpy.swift
//  TodoListViewCodeTests
//
//  Created by user on 01/08/22.
//

import UIKit

class UINavigationBarSpy: UINavigationBar {

    var didSetPrefersLargeTitle = false
    
    override var prefersLargeTitles: Bool {
        didSet {
            didSetPrefersLargeTitle = true
        }
    }

}
