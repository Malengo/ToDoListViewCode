//
//  MockCategoryModel.swift
//  TodoListViewCodeTests
//
//  Created by user on 15/07/22.
//

import Foundation
@testable import TodoListViewCode

class MockCategoryModel: TableConfigurationProtocol{
    
    func isEmptyList() -> Bool {
        return true
    }
    
    func currentTextCell(indexPath: IndexPath) -> String {
        return "Pass"
    }
    
    func getCount() -> Int {
        1
    }
    
    func getAll() {
        print("")
    }
    
    func deleteTableItem(indexPath: IndexPath) {
        print("ok")
    }
    
    
}
