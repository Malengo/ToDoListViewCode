//
//  UINavigationItemSpy.swift
//  TodoListViewCodeTests
//
//  Created by user on 01/08/22.
//

import UIKit

class UINavigationItemSpy: UINavigationItem {
    
    var didSetHidesSearchBarWhenScrolling = false
    var didSetTitle = false
    var didSetRightBarButtonItem = false
    
    override var hidesSearchBarWhenScrolling: Bool {
        didSet {
            didSetHidesSearchBarWhenScrolling = true
        }
    }
    
    override var title: String? {
        didSet {
            didSetTitle = true
        }
    }
    
    override var rightBarButtonItem: UIBarButtonItem? {
        didSet {
            didSetRightBarButtonItem = true
        }
    }
    
}
