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

    var sut: CategoryTableViewController!
    var categoryModel: CRUDModelMock!
    var coreDataView: DataTableViewMock!
    var navigationController: UINavigationControllerSpy!
    var navigationItem: UINavigationItemSpy!
    var navigationBar: UINavigationBarSpy!
    var searchData: SearchHistoryDataMock!
    var alert: UIAllertControllerSpy!
    let categoryTableViewControllerSpy = CategoryTableViewControllerSpy()
    
    override func setUp() {
        sut = CategoryTableViewController()
        navigationController = UINavigationControllerSpy()
        navigationController.viewControllers = [sut]
        navigationItem = UINavigationItemSpy()
        navigationBar = UINavigationBarSpy()
        categoryModel = CRUDModelMock()
        coreDataView = DataTableViewMock()
        searchData = SearchHistoryDataMock()
        alert = UIAllertControllerSpy()
        sut.alert = alert
        sut.coreDataView = coreDataView
        sut.categoryModel = categoryModel
        sut.searchData = searchData
    }
    
    func testViewDidLoadMustSetCategoryModelDelegate() {
        //Given
        
        //When
        sut.viewDidLoad()
        
        //Then
        XCTAssertTrue(categoryModel.didSetDelegate)
    }
    
    func testViewDidLoadMustCallCoreDataViewSetViewDelegateAndDataSource() {
        //Given
                
        //When
        sut.viewDidLoad()
        
        //Then
        XCTAssertTrue(coreDataView.wasSetViewDelegateAndDataSourceCalled)
    }
    
    func testViewDidLoad_MustConfigureAlert() {
        //Given
        let ex = expectation(description: "Wait to addAction to be called")
        ex.expectedFulfillmentCount = 2
        let textField = UITextFieldSpy()
        
        alert.addTextFieldCompletionHandler = { completion in
            completion?(textField)
        }
        
        alert.addActionCompletionHandler = { action in
            action.trigger()
            XCTAssertNotNil(action.title)
            ex.fulfill()
        }
        
        //When
        sut.viewDidLoad()
        executeSelectorAddCategory()
        
        //Then
        waitForExpectations(timeout: 1)
        XCTAssertTrue(alert.wasAddTextFieldCalled)
        XCTAssertTrue(alert.wasAddActionCalled)
        XCTAssertTrue(textField.didSetPlaceholder)
    }
        
    func testLoadView_MustCallSetupView() {
        //Given
        
        //When
        sut.loadView()
        
        //Then
        XCTAssertTrue(coreDataView.wasAddictionalConfigurationCalled)
        XCTAssertTrue(coreDataView.wasSetupConstraintsCalled)
        XCTAssertTrue(coreDataView.wasBuildViewHierachyCalled)
    }
    
    func testViewWillAppearMustSetupNavigationBar() throws {
        //Given
        
        
        //When
        sut.viewWillAppear(false)
        
        //Then
        XCTAssertEqual(sut.navigationItem.title, "Core Data", "Should be Core Data  but is \(String(describing: sut.navigationItem.title))")
        let navController = try XCTUnwrap(sut.navigationController)
        XCTAssertTrue(navController.navigationBar.prefersLargeTitles)
        XCTAssertFalse(sut.navigationItem.hidesSearchBarWhenScrolling)
        XCTAssertTrue(coreDataView.wasConfigureBarButtonCalled)
    }
    
    func testTableViewNumberOfRowsInSection_MustCallGetCount_WillReturned0() {
        //Given
        categoryModel.getCountCompletionHandler = {
            return 0
        }
        
        //When
        let result = sut.tableView(UITableView(), numberOfRowsInSection: 0)

        //Then
        XCTAssertEqual(result, 1)
        XCTAssertTrue(categoryModel.wasGetCountCalled)
    }
    
    func testTableViewNumberOfRowsInSection_MustCallGetCount_WillReturned10() {
        //Given
        categoryModel.getCountCompletionHandler = {
            return 10
        }
        
        //When
        let result = sut.tableView(UITableView(), numberOfRowsInSection: 0)

        //Then
        XCTAssertEqual(result, 10)
        XCTAssertTrue(categoryModel.wasGetCountCalled)
    }
    
    func testTableViewCellForRowAtMustCallCategoryModelGetCount() throws {
        //Given
        categoryModel.getCountCompletionHandler = {
            return 0
        }
        
        //When
        let result = sut.tableView(UITableView(), cellForRowAt: IndexPath())
        
        //Then
        XCTAssertEqual(result.textLabel?.text, "There are no Items in the Category List")
        XCTAssertTrue(categoryModel.wasGetCountCalled)
    }
    
    func testTableViewCellForRowAt_MustCallGetCount_WillReturned10_MustCallCurrentTextCell() {
        //Given
        categoryModel.getCountCompletionHandler = {
            return 10
        }
        
        //When
        let _ = sut.tableView(UITableView(), cellForRowAt: IndexPath())
        
        //Then
        XCTAssertTrue(categoryModel.wasCurrentCellTextCalled)
    }
    
    func testTableViewDidSelectRowAt_MustCallGetEntity_WhenIsNoEmptyList() {
        //Given
        categoryModel.isEmptyListCompletionHandler = {
            return false
        }
        
        navigationController.pushViewControllerCompletionHandler = { viewController, animeted in
            XCTAssertTrue(viewController is ItemOfCategoryViewController)
            
        }        //When
        sut.tableView(UITableView(), didSelectRowAt: IndexPath())
        
        //Then
        XCTAssertTrue(categoryModel.wasIsEmpyListCalled)
        XCTAssertTrue(categoryModel.wasGetEntityCalled)
        XCTAssertTrue(coreDataView.wasDeselectRowCalled)
    }
    
    func testTableViewDidSelectRowAt_MustCallDeselectRow_WhenIsEmptyList() {
        //Given
        categoryModel.isEmptyListCompletionHandler = {
            return true
        }
        //When
        sut.tableView(UITableView(), didSelectRowAt: IndexPath())
        
        //Then
        XCTAssertTrue(categoryModel.wasIsEmpyListCalled)
        XCTAssertTrue(coreDataView.wasDeselectRowCalled)
    }
    
    func testTableViewForRowAt_MustCallDeleteTableItem_WhenEditingStyleIsDelete() {
        //Given
                
        //When
        sut.tableView(UITableView(), commit: .delete, forRowAt: IndexPath())
        
        //Then
        XCTAssertTrue(categoryModel.wasDeleteTableItemCalled)
    }
    
    func testSearchBarSearchButtonClicked_MustCallGetAll_WhenIsNoTextInSearchBar() {
        //Given
        
        //When
        sut.searchBarSearchButtonClicked(UISearchBar())
        
        //Then
        XCTAssertTrue(categoryModel.wasGetAllCalled)
        XCTAssertTrue(coreDataView.wasReloadTableViewCalled)
    }
    
    func testSearchBarSearchButtonClicked_MustCallGetAll_WhenIsTextInSearchBar() {
        //Given
        let search = UISearchBar()
        search.text = "Test"
        
        //When
        sut.searchBarSearchButtonClicked(search)
        
        //Then
        XCTAssertTrue(searchData.saveDataCalled)
        XCTAssertTrue(coreDataView.wasReloadTableViewCalled)
    }
    
    func testSearchBarTextDidChange_MustCallGetCount() {
        //Given
        searchData.getCountCompletionHandler = {
            return 0
        }
        
        //When
        sut.searchBar(UISearchBar(), textDidChange: "")
        
        //Then
        XCTAssertTrue(searchData.getCountCalled)
    }
    
    func testSearchBarTextDidChange_WhenSearchTextHasNoValue_MustCallGetAll() {
        //Given
        searchData.getCountCompletionHandler = {
            return 1
        }
        
        //When
        sut.searchBar(UISearchBar(), textDidChange: "A")
        
        //Then
        XCTAssertTrue(categoryModel.wasGetAllCalled)
        XCTAssertTrue(coreDataView.wasReloadTableViewCalled)
    }
    
    func testSearchBarTextDidChange_WhenSearchTextHasValue_MustCallGetAll() {
        //Given
        searchData.getCountCompletionHandler = {
            return 1
        }
        let search = UISearchBar()
        search.text = "test"
        
        //When
        sut.searchBar(search, textDidChange: "A")
        
        //Then
        XCTAssertTrue(coreDataView.wasShowSearchHistoryCalled)
    }
    
    func testSearchBarTextDidBeginEditing_MustCallGetCount() {
        //Given
        searchData.getCountCompletionHandler = {
            return 0
        }
        
        //When
        sut.searchBarTextDidBeginEditing(UISearchBar())
        
        //Then
        XCTAssertTrue(searchData.getCountCalled)
    }
    
    func testSearchBarTextDidBeginEditing_WhenSearchTextHasValue_MustCallShowSearchHistory() {
        //Given
        searchData.getCountCompletionHandler = {
            return 1
        }
        
        let search = UISearchBar()
        search.text = "test"
        
        //When
        sut.searchBarTextDidBeginEditing(search)
        
        //Then
        XCTAssertTrue(coreDataView.wasShowSearchHistoryCalled)
    }
    
    func testSearchBarTextDidBeginEditing_WhenSearchTextHasNoValue_MustCallHideSearchHistory() {
        //Given
        searchData.getCountCompletionHandler = {
            return 1
        }
        
        //When
        sut.searchBarTextDidBeginEditing(UISearchBar())
        
        //Then
        XCTAssertTrue(coreDataView.wasHideSearchHistoryCalled)
    }
    
    func testSearchBarCancelButtonClicked_MustCallHideSearchHistory() {
        //Given
        let exp = expectation(description: "Wait for tableViewReloadData")
        coreDataView.reloadTableViewCompletionHandler = {
            exp.fulfill()
        }
        //When
        sut.searchBarCancelButtonClicked(UISearchBar())
        
        //Then
        waitForExpectations(timeout: 1)
        XCTAssertTrue(coreDataView.wasReloadTableViewCalled)
        XCTAssertTrue(coreDataView.wasHideSearchHistoryCalled)
    }
    
    func testCollectionViewNumberOfItemsInSection_MustCallGetCount() {
        //Given
                
        //When
        let _ = sut.collectionView(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()), numberOfItemsInSection: 0)
        
        //Then
        XCTAssertTrue(searchData.getCountCalled)
    }
    
    func testButtonAddCategoryPressed_MustCallPresent() {
        //Given
        
        
        
        //When
        executeSelectorAddCategory()
        
        //Then
        XCTAssertTrue(coreDataView.wasConfigureBarButtonCalled)
        XCTAssertTrue(categoryTableViewControllerSpy.wasPresentCalled)
    }
    
    private func executeSelectorAddCategory() {
        
        coreDataView.configureBarButtonCompletionHandler = { [weak self] action, target in
            let button = UIBarButtonItem()
            self?.sut = self?.categoryTableViewControllerSpy
            self?.sut.perform(action)
            return button
        }
        
        sut.viewWillAppear(false)
    }
    
    private func excuteButtonAction() {
        
        alert.addActionCompletionHandler = { action in
            action.trigger()
        }
        
        //When
        sut.viewDidLoad()
    }
    
    
    
//
//    func test_WhenCellForRowAtCalledAndGetCountEqualsZero_WillReturnedThereAreNoItemsCategoryList() {
//        //Given
//        sut.loadViewIfNeeded()
//
//        //When
//        sut.categoryModel = mockTableConfigurationProtocol
//        let result = sut.tableView(sut.coreDataView!.tableView, cellForRowAt: IndexPath())
//
//        //Then
//        XCTAssertEqual(result.textLabel?.text, "There are no Items in the Category List")
//    }
//
//    func test_WhenCellForRowAtCalledAndGetCountMoreThanZero_WillReturnedNameOfList() {
//        //Given
//        sut.loadViewIfNeeded()
//
//        //When
//        sut.categoryModel = mockTableConfigurationProtocol
//        mockTableConfigurationProtocol.list.append("Test")
//        let result = sut.tableView(sut.coreDataView!.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
//
//        //Then
//        XCTAssertEqual(result.textLabel?.text, sut.categoryModel.currentTextCell(indexPath: IndexPath(row: 1, section: 0)))
//    }
//
//    func test_WhenUITableViewCellEditingStyleDeleteCalled_WillCalledDeleteTableItem() {
//        //Given
//        sut.loadViewIfNeeded()
//
//        //When
//        sut.categoryModel = mockTableConfigurationProtocol
//        mockTableConfigurationProtocol.list.append("Test")
//        sut.tableView(sut.coreDataView!.tableView, commit: .delete, forRowAt: IndexPath())
//
//        //Then
//        XCTAssertTrue(mockTableConfigurationProtocol.deleteTableItemCalled)
//    }
//
//    func test_whenRightBarButtonPressed_WillShowAddNewCategoryAlert() {
//        //Given
//        sut.loadViewIfNeeded()
//        sut.viewWillAppear(true)
//        let barButton = sut.navigationItem.rightBarButtonItem
//
//        //When
//        sut.perform(barButton?.action)
//        //Then
//        XCTAssertEqual(alertVerifier.presentedCount, 1, "Shoulded return 1 but returned \(alertVerifier.presentedCount)")
//        XCTAssertTrue((alertVerifier.title != nil), "Should have a title, but doesn't have")
//    }
//
//    func test_whenAddCategoryPressedInTheAlert_WillCallTheFunctionSaveData() {
//        //Given
//        sut.loadViewIfNeeded()
//        sut.viewWillAppear(false)
//        sut.categoryModel = mockTableConfigurationProtocol
//        let barButton = sut.navigationItem.rightBarButtonItem
//
//        //When
//        sut.perform(barButton?.action)
//        try? alertVerifier.executeAction(forButton: "Add Category")
//
//        //Then
//        XCTAssertEqual(mockTableConfigurationProtocol.saveDataCalled, "Yes")
//    }
//
//
//
//    func test_whenSearchBarCalledTextDidChange_willCalledGetCountAnd() {
//        //Given
//        sut.loadViewIfNeeded()
//        sut.searchData = mockSearchHistoryData
//        let searchBar = UISearchBar()
//
//        //When
//        searchBar.text = "A"
//        sut.searchBar(searchBar, textDidChange: "")
//
//        //Then
//        XCTAssertTrue(mockSearchHistoryData.getCountCalled)
//    }
//
//    func test_whenSearchBarCalledSearchButtonClicked_willCalledSaveData() {
//        //Given
//        sut.loadViewIfNeeded()
//        sut.searchData = mockSearchHistoryData
//        let searchBar = UISearchBar()
//
//        //When
//        searchBar.text = "A"
//        sut.searchBarSearchButtonClicked(searchBar)
//
//        //Then
//        XCTAssertTrue(mockSearchHistoryData.saveDataCalled)
//    }
//
//    func test_whenSearchBarCalledTextDidBeginEditingAndHaveSearchBarText_willShowSearchHistory() {
//        //Given
//        sut.loadViewIfNeeded()
//        sut.searchData = mockSearchHistoryData
//        let searchBar = UISearchBar()
//
//        //When
//        mockSearchHistoryData.saveData(word: "Teste")
//        searchBar.text = "A"
//        sut.searchBarTextDidBeginEditing(searchBar)
//
//        //Then
//        guard let hidden = sut.coreDataView?.searchStack.isHidden else { return }
//        XCTAssertFalse(hidden, "Shoulded return false but return true")
//    }
//
//    func test_whenSearchBarCalledTextDidBeginEditingAndDontHaveSearchBarText_willHideSearchHistory() {
//        //Given
//        sut.loadViewIfNeeded()
//        sut.searchData = mockSearchHistoryData
//        let searchBar = UISearchBar()
//
//        //When
//        sut.searchBarTextDidBeginEditing(searchBar)
//
//        //Then
//        guard let hidden = sut.coreDataView?.searchStack.isHidden else { return }
//        XCTAssertTrue(hidden, "Shoulded return true but return false")
//    }
//
//    func test_whenSearchBarCalledsearchBarCancelButtonClicked_willHideSearchHistory() {
//        //Given
//        sut.loadViewIfNeeded()
//        sut.searchData = mockSearchHistoryData
//        let searchBar = UISearchBar()
//
//        //When
//        sut.searchBarCancelButtonClicked(searchBar)
//
//        //Then
//        guard let hidden = sut.coreDataView?.searchStack.isHidden else { return }
//        XCTAssertTrue(hidden, "Shoulded return true but return false")
//    }
//
//    func test_WhenCalledCollectionViewNumberOfItemsInSection_WillCalledSearchDataGetCount() {
//        //Given
//        sut.loadViewIfNeeded()
//
//        //When
//        sut.searchData = mockSearchHistoryData
//        let result = sut.collectionView(sut.coreDataView!.collection, numberOfItemsInSection: 0)
//
//        //Then
//        XCTAssertEqual(result, mockSearchHistoryData.getCount())
//    }
//
    func test_WhenCalledCollectionViewCellForItemAt_WillReturnSearchHistoryCell() {
        //Given
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(SearchHistoryCell.self, forCellWithReuseIdentifier: "cell")
        
        //When
        sut.searchData = searchData
        let result = sut.collectionView(collection, cellForItemAt: IndexPath(row: 1, section: 1))
        
        //Then
        XCTAssertTrue(searchData.getWordCalled)
        XCTAssertTrue(result is SearchHistoryCell)
    }
    
    func testCollectionViewCellForItemAt_WhenTrashButtonActionCalled_MustCallDeleteWord() throws {
        //Given
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(SearchHistoryCell.self, forCellWithReuseIdentifier: "cell")
        sut.searchData = searchData
        searchData.getCountCompletionHandler = {
            return 0
        }
        
        //When
        let result = try XCTUnwrap(sut.collectionView(collection, cellForItemAt: IndexPath(row: 1, section: 1))) as? SearchHistoryCell
        result?.deleteButton.sendActions(for: .touchDown)
        
        //Then
        XCTAssertTrue(searchData.deleteWordCalled)
        XCTAssertTrue(searchData.getCountCalled)
        XCTAssertTrue(coreDataView.wasHideSearchHistoryCalled, "Should be true when search.getCount equals Zero, but is false")
    }
    
    func testCollectionViewCellForItemAt_WhenTextSearchbuttonCalled_MustCallSetTextSearchBar() throws {
        //Given
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(SearchHistoryCell.self, forCellWithReuseIdentifier: "cell")
        sut.searchData = searchData
        
        //When
        let result = try XCTUnwrap(sut.collectionView(collection, cellForItemAt: IndexPath(row: 1, section: 1))) as? SearchHistoryCell
        result?.textSearchButton.setTitle("test", for: .normal)
        result?.textSearchButton.sendActions(for: .touchDown)
        
        //Then
        XCTAssertTrue(coreDataView.wasSetTextSearchBarCalled)
    }
    
//
//    func test_WhenConfiguredCollectionViewCell_WillActionAddButton() {
//        //Given
//        sut.loadViewIfNeeded()
//
//        //When
//        sut.searchData = mockSearchHistoryData
//        let result = sut.collectionView(sut.coreDataView!.collection, cellForItemAt: IndexPath(row: 1, section: 0)) as? SearchHistoryCell
//
//        result?.buttonAdd.sendActions(for: .touchDown)
//    }
//
//    func test_WhenConfiguredCollectionViewCell_WillActionTrashButton() {
//        //Given
//        sut.loadViewIfNeeded()
//
//        //When
//        sut.searchData = mockSearchHistoryData
//        let result = sut.collectionView(sut.coreDataView!.collection, cellForItemAt: IndexPath(row: 1, section: 0)) as? SearchHistoryCell
//
//        result?.deleteButton.sendActions(for: .touchDown)
//
//        //Then
//        XCTAssertTrue(mockSearchHistoryData.deleteWordCalled)
//    }
//
//    func test_whenSearchBarCalledSearchButtonClickedAndDoNotHaveText_willCalledGetAll() {
//        //Given
//        sut.loadViewIfNeeded()
//        sut.categoryModel = mockTableConfigurationProtocol
//        let searchBar = UISearchBar()
//        searchBar.text = ""
//        //When
//        sut.searchBarSearchButtonClicked(searchBar)
//
//        //Then
//        XCTAssertTrue(mockTableConfigurationProtocol.getAllCalled)
//    }
//
//    func test_whenSearchBarCalledTextDidChangeAndDoNotHaveText_willCalledGetAll() {
//        //Given
//        sut.loadViewIfNeeded()
//        sut.categoryModel = mockTableConfigurationProtocol
//        sut.searchData = mockSearchHistoryData
//        let searchBar = UISearchBar()
//
//        //When
//        mockSearchHistoryData.saveData(word: "Test")
//        searchBar.text = ""
//        sut.searchBar(searchBar, textDidChange: "")
//
//        //Then
//        XCTAssertTrue(mockTableConfigurationProtocol.getAllCalled)
//    }

}

extension UIAlertAction {
    typealias AlertHandler = @convention(block) (UIAlertAction) -> Void
    func trigger() {
        guard let block = value(forKey: "handler") else {
            XCTFail("Should not be here")
            return
        }
        let handler = unsafeBitCast(block as AnyObject, to: AlertHandler.self)
        handler(self)
    }
}

