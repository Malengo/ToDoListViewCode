//
//  MainViewMock.swift
//  TodoListViewCodeTests
//
//  Created by user on 01/08/22.
//

import UIKit
@testable import TodoListViewCode

class MainViewMock: UIView, MainViewProtocol {
    
    var wasSetupButtonsCalled: Bool = false
    var wasBuildViewHierachyCalled: Bool = false
    var wasSetupConstraintsCalled: Bool = false
    var wasAddictionalConfigurationCalled: Bool = false
    
    func setupButtons(target: Any?, coredata: Selector, realm: Selector, firebase: Selector) {
        wasSetupButtonsCalled = true
    }
    
    func buildViewHierachy() {
        wasBuildViewHierachyCalled = true
    }
    
    func setupConstraints() {
        wasSetupConstraintsCalled = true
    }
    
    func addictionalConfiguration() {
        wasAddictionalConfigurationCalled = true
    }
    
}
