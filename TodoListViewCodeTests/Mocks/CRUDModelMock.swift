//
//  MockDataProtocol.swift
//  TodoListViewCodeTests
//
//  Created by user on 18/07/22.
//

import Foundation
import UIKit
@testable import TodoListViewCode

class CRUDModelMock: CRUDModelProtocol {

    var wasIsEmpyListCalled = false
    var wasGetEntityCalled = false
    var wasDeleteTableItemCalled = false
    var wasSaveDataCalled = false
    var wasGetAllCalled = false
    var wasGetCountCalled = false
    var wasCurrentCellTextCalled = false
    var didSetDelegate = false
    var getCountCompletionHandler: (() -> Int)?
    var isEmptyListCompletionHandler: (() -> Bool)?
    
    var delegate: UpdateTableProtocol? {
        didSet {
            didSetDelegate = true
        }
    }
    
    var list: [Any] = []
    
    func saveData(data: String) {
        wasSaveDataCalled = true
    }
    
    func isEmptyList() -> Bool {
        wasIsEmpyListCalled = true
        return isEmptyListCompletionHandler?() ?? false
    }
    
    func currentTextCell(indexPath: IndexPath) -> String {
        wasCurrentCellTextCalled = true
        return ""
    }
    
    func getCount() -> Int {
        wasGetCountCalled = true
        return getCountCompletionHandler?() ?? -1
    }
    
    func getAll() {
        wasGetAllCalled = true
    }
    
    func deleteTableItem(indexPath: IndexPath) {
        wasDeleteTableItemCalled = true
    }
    
    func getEntity(indexPath: IndexPath) -> AnyObject {
        wasGetEntityCalled = true
        return UIView()
    }
        
}
