//
//  MainViewControllerTests.swift
//  TodoListViewCodeTests
//
//  Created by user on 13/07/22.
//

import XCTest
import ViewControllerPresentationSpy
@testable import TodoListViewCode

class MainViewControllerTests: XCTestCase {
    
    var sut: MainViewController!
    var navigation: UINavigationController!

    override func setUpWithError() throws {
        
        sut = MainViewController()
        navigation = UINavigationController(rootViewController: sut)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_LoadingMainViewController() {
        //Given
        
        //When
        sut.loadViewIfNeeded()
        
        //Then
        XCTAssertNotNil(sut.mainView, "mainview shoulded return not nil, but returned nil")
    }
    
    func test_WhenButtonCoreDataPressed_WillCalledCategoryViewController() {
        //Given
        
        //When
        sut.loadViewIfNeeded()
        sut.mainView?.coreDataButton.sendActions(for: .touchDown)
        RunLoop.current.run(until: Date())
        let pushedVc = navigation.topViewController
        guard let _ = pushedVc as? CategoryTableViewController else {
            //Then
            XCTFail("Expected CategoryTableViewController, but was \(String(describing: pushedVc))")
            return
        }
    }
    
    func test_WhenRealmButtonPressed_WillCalledCategoryRealmViewController() {
        //Given
        
        //When
        sut.loadViewIfNeeded()
        sut.mainView?.realmButton.sendActions(for: .touchDown)
        RunLoop.current.run(until: Date())
        let pushedVc = navigation.topViewController
        guard let _ = pushedVc as? CategoryRealmViewController else {
            //Then
            XCTFail("Expected CategoryRealmViewController, but was \(String(describing: pushedVc))")
            return
        }
    }
    
    func test_WhenFireBaseButtonPressed_WillCalledCategoryFireBaseViewController() {
        //Given
        //When
        sut.loadViewIfNeeded()
        sut.mainView?.firebaseButton.sendActions(for: .touchDown)
        RunLoop.current.run(until: Date())
        let pushedVc = navigation.topViewController
        guard let _ = pushedVc as? CategoryFireBaseViewController else {
            //Then
            XCTFail("Expected CategoryFireBaseViewController, but was \(String(describing: pushedVc))")
            return
        }
    }
    
    func testSpyViewController() {
        sut.loadViewIfNeeded()
        let spy = SpyNavigationController(rootViewController: sut)
        sut.mainView?.coreDataButton.sendActions(for: .touchDown)
        guard let _ = spy.pushedViewController as? CategoryTableViewController else {
            print(spy.pushedViewController)
            XCTFail()
            return
        }
    }

}
