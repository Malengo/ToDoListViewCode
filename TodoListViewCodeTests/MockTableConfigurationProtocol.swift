//
//  MockDataProtocol.swift
//  TodoListViewCodeTests
//
//  Created by user on 18/07/22.
//

import Foundation
@testable import TodoListViewCode

class MockTableConfigurationProtocol: TableConfigurationProtocol {
    
    var delegate: UpdateTableProtocol?
    
    var list: [Any] = []
    
    var isEmpyListCalled = false
    var getEntityCalled = false
    var deleteTableItemCalled = false
    var saveDataCalled: String = "No"
    
    func saveData(data: String) {
        list.append(data)
    }
    
    func isEmptyList() -> Bool {
        isEmpyListCalled = true
        return list.isEmpty
    }
    
    func currentTextCell(indexPath: IndexPath) -> String {
        return "Ok"
    }
    
    func getCount() -> Int {
        return list.count
    }
    
    func getAll() {
        
    }
    
    func deleteTableItem(indexPath: IndexPath) {
        deleteTableItemCalled = true
    }
    
    func getEntity(indexPath: IndexPath) -> AnyObject {
        getEntityCalled = true
        return MockTableConfigurationProtocol()
    }
        
}
