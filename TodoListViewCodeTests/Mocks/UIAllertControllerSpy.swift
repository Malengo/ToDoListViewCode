//
//  UIAllertControllerSpy.swift
//  TodoListViewCodeTests
//
//  Created by user on 05/08/22.
//

import UIKit

class UIAllertControllerSpy: UIAlertController {

    var wasAddActionCalled = false
    var wasAddTextFieldCalled = false
    
    var addActionCompletionHandler: ((_ action: UIAlertAction) -> Void)?
    var addTextFieldCompletionHandler: ((_ configurationHandler: ((UITextField) -> Void)?) -> Void)?
    
    override func addAction(_ action: UIAlertAction) {
        wasAddActionCalled = true
        addActionCompletionHandler?(action)
    }
    
    override func addTextField(configurationHandler: ((UITextField) -> Void)? = nil) {
        wasAddTextFieldCalled = true
        addTextFieldCompletionHandler?(configurationHandler)
    }
    
}
