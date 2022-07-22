//
//  CategoryTableViewControllerTests.swift
//  TodoListViewCodeTests
//
//  Created by user on 15/07/22.
//

import XCTest
import ViewControllerPresentationSpy
@testable import TodoListViewCode

class CategoryTableViewControllerTests: XCTestCase {

    var alertVerifier: AlertVerifier!
    var sut: CategoryTableViewController!
    let mockTableConfigurationProtocol = MockTableConfigurationProtocol()
    let mockSearchHistoryData = MockSearchHistoryData()
    
    override func setUpWithError() throws {
        alertVerifier = AlertVerifier()
        sut = CategoryTableViewController()
    }
    
    override func tearDownWithError() throws {
        alertVerifier = nil
        sut = nil
    }
    
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
        
    func test_WhenCalledDidSelectRowAndListEmpty_WillCalledIsEmptyListMethod() {
        //Given
        sut.loadViewIfNeeded()
        
        //When
        sut.categoryModel = mockTableConfigurationProtocol
        sut.tableView(sut.coreDataView!.tableView, didSelectRowAt: IndexPath())
        
        //Then
        XCTAssertTrue(mockTableConfigurationProtocol.isEmpyListCalled)
    }
    
    func test_WhenCalledDidSelectRowAndisItemInTheList_WillCalledGetEntityMethod() {
        //Given
        sut.loadViewIfNeeded()
        
        //When
        sut.categoryModel = mockTableConfigurationProtocol
        mockTableConfigurationProtocol.list.append("Test")
        sut.tableView(sut.coreDataView!.tableView, didSelectRowAt: IndexPath())
        
        //Then
        XCTAssertTrue(mockTableConfigurationProtocol.getEntityCalled)
    }
    
    func test_WhenCallednumberOfRowsInSection_WillReturned1() {
        //Given
        sut.loadViewIfNeeded()
        
        //When
        sut.categoryModel = mockTableConfigurationProtocol
        mockTableConfigurationProtocol.list.append("Test")
        let result = sut.tableView(sut.coreDataView!.tableView, numberOfRowsInSection: 0)
        
        //Then
        XCTAssertEqual(result, 1)
    }
    
    func test_WhenCellForRowAtCalledAndGetCountEqualsZero_WillReturnedThereAreNoItemsCategoryList() {
        //Given
        sut.loadViewIfNeeded()
        
        //When
        sut.categoryModel = mockTableConfigurationProtocol
        let result = sut.tableView(sut.coreDataView!.tableView, cellForRowAt: IndexPath())
        
        //Then
        XCTAssertEqual(result.textLabel?.text, "There are no Items in the Category List")
    }
    
    func test_WhenCellForRowAtCalledAndGetCountMoreThanZero_WillReturnedNameOfList() {
        //Given
        sut.loadViewIfNeeded()
        
        //When
        sut.categoryModel = mockTableConfigurationProtocol
        mockTableConfigurationProtocol.list.append("Test")
        let result = sut.tableView(sut.coreDataView!.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        
        //Then
        XCTAssertEqual(result.textLabel?.text, sut.categoryModel.currentTextCell(indexPath: IndexPath(row: 1, section: 0)))
    }
    
    func test_WhenUITableViewCellEditingStyleDeleteCalled_WillCalledDeleteTableItem() {
        //Given
        sut.loadViewIfNeeded()
        
        //When
        sut.categoryModel = mockTableConfigurationProtocol
        mockTableConfigurationProtocol.list.append("Test")
        sut.tableView(sut.coreDataView!.tableView, commit: .delete, forRowAt: IndexPath())
        
        //Then
        XCTAssertTrue(mockTableConfigurationProtocol.deleteTableItemCalled)
    }
    
    func test_whenRightBarButtonPressed_WillShowAddNewCategoryAlert() {
        //Given
        sut.loadViewIfNeeded()
        sut.viewWillAppear(true)
        let barButton = sut.navigationItem.rightBarButtonItem
        
        //When
        sut.perform(barButton?.action)
        //Then
        XCTAssertEqual(alertVerifier.presentedCount, 1, "Shoulded return 1 but returned \(alertVerifier.presentedCount)")
        XCTAssertTrue((alertVerifier.title != nil), "Should have a title, but doesn't have")
    }
    
    func test_whenAddCategoryPressedInTheAlert_WillCallTheFunctionSaveData() {
        //Given
        sut.loadViewIfNeeded()
        sut.viewWillAppear(false)
        sut.categoryModel = mockTableConfigurationProtocol
        let barButton = sut.navigationItem.rightBarButtonItem
        
        //When
        sut.perform(barButton?.action)
        try? alertVerifier.executeAction(forButton: "Add Category")
        
        //Then
        XCTAssertEqual(mockTableConfigurationProtocol.saveDataCalled, "Yes")
    }
    
    func test_whenSearchBarCalledTextDidChange_willCalledGetCountAnd() {
        //Given
        sut.loadViewIfNeeded()
        sut.searchData = mockSearchHistoryData
        let searchBar = UISearchBar()
        
        //When
        searchBar.text = "A"
        sut.searchBar(searchBar, textDidChange: "")
        
        //Then
        XCTAssertTrue(mockSearchHistoryData.getCountCalled)
    }
    
    func test_whenSearchBarCalledSearchButtonClicked_willCalledSaveData() {
        //Given
        sut.loadViewIfNeeded()
        sut.searchData = mockSearchHistoryData
        let searchBar = UISearchBar()
        
        //When
        searchBar.text = "A"
        sut.searchBarSearchButtonClicked(searchBar)
        
        //Then
        XCTAssertTrue(mockSearchHistoryData.saveDataCalled)
    }
    
    func test_whenSearchBarCalledTextDidBeginEditingAndHaveSearchBarText_willShowSearchHistory() {
        //Given
        sut.loadViewIfNeeded()
        sut.searchData = mockSearchHistoryData
        let searchBar = UISearchBar()
        
        //When
        mockSearchHistoryData.saveData(word: "Teste")
        searchBar.text = "A"
        sut.searchBarTextDidBeginEditing(searchBar)
        
        //Then
        guard let hidden = sut.coreDataView?.searchStack.isHidden else { return }
        XCTAssertFalse(hidden, "Shoulded return false but return true")
    }
    
    func test_whenSearchBarCalledTextDidBeginEditingAndDontHaveSearchBarText_willHideSearchHistory() {
        //Given
        sut.loadViewIfNeeded()
        sut.searchData = mockSearchHistoryData
        let searchBar = UISearchBar()
        
        //When
        sut.searchBarTextDidBeginEditing(searchBar)
        
        //Then
        guard let hidden = sut.coreDataView?.searchStack.isHidden else { return }
        XCTAssertTrue(hidden, "Shoulded return true but return false")
    }
    
    func test_whenSearchBarCalledsearchBarCancelButtonClicked_willHideSearchHistory() {
        //Given
        sut.loadViewIfNeeded()
        sut.searchData = mockSearchHistoryData
        let searchBar = UISearchBar()
        
        //When
        sut.searchBarCancelButtonClicked(searchBar)
        
        //Then
        guard let hidden = sut.coreDataView?.searchStack.isHidden else { return }
        XCTAssertTrue(hidden, "Shoulded return true but return false")
    }
    
    func test_WhenCalledCollectionViewNumberOfItemsInSection_WillCalledSearchDataGetCount() {
        //Given
        sut.loadViewIfNeeded()
        
        //When
        sut.searchData = mockSearchHistoryData
        let result = sut.collectionView(sut.coreDataView!.collection, numberOfItemsInSection: 0)
        
        //Then
        XCTAssertEqual(result, mockSearchHistoryData.getCount())
    }
    
    func test_WhenCalledCollectionViewCellForItemAt_WillReturnSearchHistoryCell() {
        //Given
        sut.loadViewIfNeeded()
        
        //When
        sut.searchData = mockSearchHistoryData
        guard let _ = sut.collectionView(sut.coreDataView!.collection, cellForItemAt: IndexPath(row: 1, section: 0)) as? SearchHistoryCell else {
            //Then
            XCTFail()
            return
        }
    }
    
    func test_WhenConfiguredCollectionViewCell_WillActionAddButton() {
        //Given
        sut.loadViewIfNeeded()
        
        //When
        sut.searchData = mockSearchHistoryData
        let result = sut.collectionView(sut.coreDataView!.collection, cellForItemAt: IndexPath(row: 1, section: 0)) as? SearchHistoryCell
        
        result?.buttonAdd.sendActions(for: .touchDown)
    }
    
    func test_WhenConfiguredCollectionViewCell_WillActionTrashButton() {
        //Given
        sut.loadViewIfNeeded()
        
        //When
        sut.searchData = mockSearchHistoryData
        let result = sut.collectionView(sut.coreDataView!.collection, cellForItemAt: IndexPath(row: 1, section: 0)) as? SearchHistoryCell
        
        result?.deleteButton.sendActions(for: .touchDown)
        
        //Then
        XCTAssertTrue(mockSearchHistoryData.deleteWordCalled)
    }
    
    func test_whenSearchBarCalledSearchButtonClickedAndDoNotHaveText_willCalledGetAll() {
        //Given
        sut.loadViewIfNeeded()
        sut.categoryModel = mockTableConfigurationProtocol
        let searchBar = UISearchBar()
        searchBar.text = ""
        //When
        sut.searchBarSearchButtonClicked(searchBar)
        
        //Then
        XCTAssertTrue(mockTableConfigurationProtocol.getAllCalled)
    }
    
    func test_whenSearchBarCalledTextDidChangeAndDoNotHaveText_willCalledGetAll() {
        //Given
        sut.loadViewIfNeeded()
        sut.categoryModel = mockTableConfigurationProtocol
        sut.searchData = mockSearchHistoryData
        let searchBar = UISearchBar()
        
        //When
        mockSearchHistoryData.saveData(word: "Test")
        searchBar.text = ""
        sut.searchBar(searchBar, textDidChange: "")
        
        //Then
        XCTAssertTrue(mockTableConfigurationProtocol.getAllCalled)
    }

}

