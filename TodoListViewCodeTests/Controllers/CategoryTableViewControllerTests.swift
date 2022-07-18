//
//  CategoryTableViewControllerTests.swift
//  TodoListViewCodeTests
//
//  Created by user on 15/07/22.
//

import XCTest
@testable import TodoListViewCode
class CategoryTableViewControllerTests: XCTestCase {

    let sut = CategoryTableViewController ()

    func test_whenCategoryTableViewControllerLoaded_willTableviewDataSourceAndDelegateIsNotNil() {
        //Given
        //When
        sut.loadViewIfNeeded()
        
        //Then
        XCTAssertNotNil(sut.coreDataView?.tableView.dataSource, "TableView DataSorce Should be not nil, but returned NIL")
        
        XCTAssertNotNil(sut.coreDataView?.tableView.delegate, "TableView Delegate should be not nil, but returned NIL")
    }
    
    func test_whenCategoryTableViewControllerLoaded_willReturnedSearchbarDelegateIsNotNil() {
        //Given
        //When
        sut.loadViewIfNeeded()
        
        //Then
        XCTAssertNotNil(sut.coreDataView?.searchBar.delegate, "SearchBar Delegate should be not nil, but returned NIL")
    }
    
    func test_whenCategoryTableViewControllerLoaded_willReturnedCollectionViewDelegateAndDataSourceIsNotNil() {
        //Given
        //When
        sut.loadViewIfNeeded()
        
        //Then
        XCTAssertNotNil(sut.coreDataView?.collection.delegate, "CollectionView Delegate should be not nil, but returned NIL")
        XCTAssertNotNil(sut.coreDataView?.collection.dataSource, "CollectionView dataSource should be not nil, but returned NIL")
    }
    
    func test_whenCategoryTableViewControllerLoaded_willReturnedSearchBarPlaceholderTextSearch() {
        //Given
        //When
        sut.loadViewIfNeeded()

        //Then
        XCTAssertEqual(sut.coreDataView?.searchBar.placeholder, "Search......")
        XCTAssertNotNil(sut.coreDataView?.searchBar.placeholder?.isEmpty, "Placeholder shoud have a text, but is nil")
    }
    
    func test_whenCategoryTableViewControllerCalledViewWillappear_willSetedNavigationTitle() {
        //Given
        //When
        sut.loadViewIfNeeded()
        sut.viewWillAppear(false)
        //Then
        XCTAssertNotNil(sut.navigationItem.title)
        XCTAssertEqual(sut.navigationItem.title, "Core Data", "Should be Core Data  but is \(String(describing: sut.navigationItem.title))")
    }
    
    func test_whenRigthBarButtonPressed_WillCallTheFunctionbuttonAddCategoryPressed() {
        //Given
        sut.loadViewIfNeeded()
        //When
        sut.viewWillAppear(false)
        let barButton = sut.navigationItem.rightBarButtonItem?.action
        sut.perform(barButton)
        //Then
       // XCTAssertTrue(sut.buttonAddCategoryPressed, 1)
    }
}
