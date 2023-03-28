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
    var navigation: UINavigationControllerSpy!
    var mainViewMock: MainViewMock!

    override func setUp() {
        sut = MainViewController()
        navigation = UINavigationControllerSpy()
        navigation.viewControllers = [sut]
        mainViewMock = MainViewMock()
        sut.mainView = mainViewMock
    }
    
    func testViewDidLoadMustSetupButtons() {
        //Given
    
        //When
        sut.viewDidLoad()
        //Then
        XCTAssertTrue(mainViewMock.wasSetupButtonsCalled)
    }
    
    func testViewDidloadMustSetNavigationItemTitle() {
        //Given
        
        //When
        sut.viewDidLoad()
        
        //Then
        XCTAssertEqual(sut.navigationItem.title, "ToDo List with data")
    }
    
    func testLoadViewMustLoadView() {
        //Given
        
        //When
        sut.loadView()
        
        //Then
        XCTAssertTrue(mainViewMock.wasAddictionalConfigurationCalled)
        XCTAssertTrue(mainViewMock.wasSetupConstraintsCalled)
        XCTAssertTrue(mainViewMock.wasBuildViewHierachyCalled)
        XCTAssertTrue(sut.view is MainViewMock)
    }
    
    func test_WhenButtonCoreDataPressed_WillCalledCategoryViewController() {
        //Given
        let exp = expectation(description: "Waiting for Navigation pushViewController to be called")
        
        navigation.pushViewControllerCompletionHandler = { viewController, animated in
            XCTAssertTrue(viewController is CategoryTableViewController)
            XCTAssertTrue(animated)
            exp.fulfill()
        }
        
        //When
        sut.coreDataButtonPressed()
        
        //Then
        waitForExpectations(timeout: 1)
        XCTAssertTrue(navigation.wasPushViewControllerCalled)
    }

    func test_WhenRealmButtonPressed_WillCalledCategoryRealmViewController() {
        //Given
        let exp = expectation(description: "Waiting for Navigation pushViewController to be called")
        
        navigation.pushViewControllerCompletionHandler = { viewController, animated in
            XCTAssertTrue(viewController is CategoryRealmViewController)
            XCTAssertTrue(animated)
            exp.fulfill()
        }
        
        //When
        sut.realmButtonPressed()
        
        //Then
        waitForExpectations(timeout: 1)
        XCTAssertTrue(navigation.wasPushViewControllerCalled)
    }

    func test_WhenFireBaseButtonPressed_WillCalledCategoryFireBaseViewController() {
        //Given
        let exp = expectation(description: "Waiting for Navigation pushViewController to be called")
        
        navigation.pushViewControllerCompletionHandler = { viewController, animated in
            XCTAssertTrue(viewController is CategoryFireBaseViewController)
            XCTAssertTrue(animated)
            exp.fulfill()
        }
        
        //When
        sut.fireBaseButtonPressed()
        
        //Then
        waitForExpectations(timeout: 1)
        XCTAssertTrue(navigation.wasPushViewControllerCalled)
    }

}
////Given
//let viewModel =  BPFSecurityKeyQRCodeReader.ConfigureScreen.ViewModel(
//    screenTitle: "Title"
//)
//
//let exp = expectation(description: "Waiting for notificationCenter")
//notificationCenter.addObserverCompletionHandler = { observer, selector, name, object in
//    XCTAssertEqual(name, UIApplication.willResignActiveNotification)
//    XCTAssertEqual(selector.description, "backToSecurityKeyList")
//    exp.fulfill()
//}
//
////When
//sut.displayConfigureScreen(viewModel: viewModel)
//
////Then
//waitForExpectations(timeout: 1)
//XCTAssertTrue(notificationCenter.wasAddObserverCalled)
