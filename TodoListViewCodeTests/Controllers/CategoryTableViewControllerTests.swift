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
    let output = MockTableConfigurationProtocol()
    
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
    
//    func test_whenRigthBarButtonPressed_WillCallTheFunctionbuttonAddCategoryPressed() {
//        //Given
//        sut.loadViewIfNeeded()
//
//        //When
//        sut.viewWillAppear(false)
//        sut.categoryModel = output
//        let barButton = sut.navigationItem.rightBarButtonItem
//        sut.perform(barButton?.action)
//
//        //Then
//        XCTAssertEqual(output.saveDataCalled, "Yes")
//    }
    
    func test_WhenCalledDidSelectRowAndListEmpty_WillCalledIsEmptyListMethod() {
        //Given
        sut.loadViewIfNeeded()
        
        //When
        sut.categoryModel = output
        sut.tableView(sut.coreDataView!.tableView, didSelectRowAt: IndexPath())
        
        //Then
        XCTAssertTrue(output.isEmpyListCalled)
    }
    
    func test_WhenCalledDidSelectRowAndisItemInTheList_WillCalledGetEntityMethod() {
        //Given
        sut.loadViewIfNeeded()
        
        //When
        sut.categoryModel = output
        output.list.append("Test")
        sut.tableView(sut.coreDataView!.tableView, didSelectRowAt: IndexPath())
        
        //Then
        XCTAssertTrue(output.getEntityCalled)
    }
    
    func test_WhenCallednumberOfRowsInSection_WillReturned1() {
        //Given
        sut.loadViewIfNeeded()
        
        //When
        sut.categoryModel = output
        output.list.append("Test")
        let result = sut.tableView(sut.coreDataView!.tableView, numberOfRowsInSection: 0)
        
        //Then
        XCTAssertEqual(result, 1)
    }
    
    func test_WhenCellForRowAtCalledAndGetCountEqualsZero_WillReturnedThereAreNoItemsCategoryList() {
        //Given
        sut.loadViewIfNeeded()
        
        //When
        sut.categoryModel = output
        let result = sut.tableView(sut.coreDataView!.tableView, cellForRowAt: IndexPath())
        
        //Then
        XCTAssertEqual(result.textLabel?.text, "There are no Items in the Category List")
    }
    
    func test_WhenCellForRowAtCalledAndGetCountMoreThanZero_WillReturnedNameOfList() {
        //Given
        sut.loadViewIfNeeded()
        
        //When
        sut.categoryModel = output
        output.list.append("Test")
        let result = sut.tableView(sut.coreDataView!.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        
        //Then
        XCTAssertEqual(result.textLabel?.text, sut.categoryModel.currentTextCell(indexPath: IndexPath(row: 1, section: 0)))
    }
    
    func test_WhenUITableViewCellEditingStyleDeleteCalled_WillCalledDeleteTableItem() {
        //Given
        sut.loadViewIfNeeded()
        
        //When
        sut.categoryModel = output
        output.list.append("Test")
        sut.tableView(sut.coreDataView!.tableView, commit: .delete, forRowAt: IndexPath())
        
        //Then
        XCTAssertTrue(output.deleteTableItemCalled)
    }
}
