//
//  MainViewControllerTests.swift
//  TodoListViewCodeTests
//
//  Created by user on 13/07/22.
//

import XCTest
@testable import TodoListViewCode

class MainViewControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_LoadingMainViewController() {
        //Given
        let sut = MainViewController()
        
        //When
        sut.loadViewIfNeeded()
        
        //Then
        XCTAssertNotNil(sut.mainView, "mainview shoulded return not nil, but returned nil")
    }

}
