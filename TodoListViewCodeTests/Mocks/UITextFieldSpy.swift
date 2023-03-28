//
//  UITextFieldSpy.swift
//  TodoListViewCodeTests
//
//  Created by user on 09/08/22.
//

import UIKit

class UITextFieldSpy: UITextField {

    var didSetPlaceholder = false
    
    override var placeholder: String? {
        didSet {
            didSetPlaceholder = true
        }
    }
}
