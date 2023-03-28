//
//  CategoryModelTests.swift
//  TodoListViewCodeTests
//
//  Created by user on 14/07/22.
//

import XCTest
@testable import TodoListViewCode

class CategoryModelTests: XCTestCase {
    
    var sut: CategoryModel!
    var mock: CRUDModelMock!
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        sut = CategoryModel()
        mock = CRUDModelMock()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testAdd() {
        
    }
    

}
