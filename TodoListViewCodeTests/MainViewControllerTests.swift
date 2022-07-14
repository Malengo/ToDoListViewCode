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
    
    func test_WhenButtonCoreDataPressed_WillCalledCategoryViewController() {
        //Given
        let sut = MainViewController()
        
        //When
        sut.loadViewIfNeeded()
        let navigation = UINavigationController(rootViewController: sut)
        sut.mainView?.coreDataButton.sendActions(for: .touchDown)
        RunLoop.current.run(until: Date())
        let pushedVc = navigation.viewControllers.last
        guard let _ = pushedVc as? CategoryTableViewController else {
            //Then
            XCTFail("Expected CategoryTableViewController, but was \(String(describing: pushedVc))")
            return
        }
    }
    
    func test_WhenRealmButtonPressed_WillCalledCategoryRealmViewController() {
        //Given
        let sut = MainViewController()
        
        //When
        sut.loadViewIfNeeded()
        let navigation = UINavigationController(rootViewController: sut)
        sut.mainView?.realmButton.sendActions(for: .touchDown)
        RunLoop.current.run(until: Date())
        let pushedVc = navigation.viewControllers.last
        guard let _ = pushedVc as? CategoryRealmViewController else {
            //Then
            XCTFail("Expected CategoryRealmViewController, but was \(String(describing: pushedVc))")
            return
        }
    }
    
    func test_WhenFireBaseButtonPressed_WillCalledCategoryFireBaseViewController() {
        //Given
        let sut = MainViewController()
        
        //When
        sut.loadViewIfNeeded()
        let navigation = UINavigationController(rootViewController: sut)
        sut.mainView?.firebaseButton.sendActions(for: .touchDown)
        RunLoop.current.run(until: Date())
        let pushedVc = navigation.viewControllers.last
        guard let _ = pushedVc as? CategoryFireBaseViewController else {
            //Then
            XCTFail("Expected CategoryFireBaseViewController, but was \(String(describing: pushedVc))")
            return
        }
    }

}
