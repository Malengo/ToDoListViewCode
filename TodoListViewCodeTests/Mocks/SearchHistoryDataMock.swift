//
//  MockSearchHistoryData.swift
//  TodoListViewCodeTests
//
//  Created by user on 20/07/22.
//

import Foundation
@testable import TodoListViewCode

class SearchHistoryDataMock: CRUDSearchHistoryProtocol {
    
    var list: [String] = []
    var readDataCalled: Bool = false
    var saveDataCalled: Bool = false
    var getCountCalled: Bool = false
    var getWordCalled: Bool = false
    var deleteWordCalled: Bool = false
    var getCountCompletionHandler: (() -> Int)?
    
    func readData() -> [String] {
        readDataCalled = true
        return []
    }
    
    func saveData(word: String) {
        saveDataCalled = true
    }
    
    func getCount() -> Int {
        getCountCalled = true
        return getCountCompletionHandler?() ?? -1
    }
    
    func getWord(index: Int) -> String {
        getWordCalled = true
        return ""
    }
    
    func deleteWord(index: Int) {
        deleteWordCalled = true
    }
    
}
