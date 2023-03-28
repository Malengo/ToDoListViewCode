//
//  DataTableViewMock.swift
//  TodoListViewCodeTests
//
//  Created by user on 01/08/22.
//

import Foundation
import UIKit
@testable import TodoListViewCode

class DataTableViewMock: UIView, DataTableViewProtocol {
    
    var wasBuildViewHierachyCalled: Bool = false
    var wasSetupConstraintsCalled: Bool = false
    var wasAddictionalConfigurationCalled: Bool = false
    var wasSetViewDelegateAndDataSourceCalled: Bool = false
    var wasDeselectRowCalled: Bool = false
    var wasConfigureBarButtonCalled: Bool = false
    var wasReloadTableViewCalled: Bool = false
    var wasShowSearchHistoryCalled: Bool = false
    var wasHideSearchHistoryCalled: Bool = false
    var wasSetTextSearchBarCalled: Bool = false
    var reloadTableViewCompletionHandler: (() -> Void)?
    var configureBarButtonCompletionHandler: ((_ action: Selector, _ target: AnyObject) -> UIBarButtonItem)?
    
    func setViewDelegateAndDataSource(to delegate: UICollectionViewDataSource & UICollectionViewDelegate & UISearchBarDelegate & UITableViewDataSource & UITableViewDelegate) {
        wasSetViewDelegateAndDataSourceCalled = true
    }
    
    func configureBarButton(action: Selector, target: AnyObject) -> UIBarButtonItem {
        wasConfigureBarButtonCalled = true
        return configureBarButtonCompletionHandler?(action, target) ?? UIBarButtonItem()
    }
    
    func deselectRow(at index: IndexPath, animated: Bool) {
        wasDeselectRowCalled = true
    }
    
    func reloadTableViewData() {
        wasReloadTableViewCalled = true
        reloadTableViewCompletionHandler?()
    }
    
    func reloadCollectionViewData() {
        
    }
    
    func hideSearchHistory() {
        wasHideSearchHistoryCalled = true
    }
    
    func showSearchHistory() {
        wasShowSearchHistoryCalled = true
    }
    
    func setTextSearchBar(text: String) {
        wasSetTextSearchBarCalled = true
    }
    
    func buildViewHierachy() {
        wasBuildViewHierachyCalled = true
    }
    
    func setupConstraints() {
        wasSetupConstraintsCalled = true
    }
    
    func addictionalConfiguration() {
       wasAddictionalConfigurationCalled = true
    }
    
    
}
