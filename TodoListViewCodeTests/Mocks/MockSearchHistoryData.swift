//
//  MockSearchHistoryData.swift
//  TodoListViewCodeTests
//
//  Created by user on 20/07/22.
//

import Foundation
@testable import TodoListViewCode

class MockSearchHistoryData: SearchHistoryProtocol {
    
    var readDataCalled: Bool = false
    var saveDataCalled: Bool = false
    var getCountCalled: Bool = false
    var getWordCalled: String = "No"
    var deleteWordCalled: Bool = false
    
    func readData() -> [String] {
        readDataCalled = true
        return []
    }
    
    func saveData(word: String) {
        saveDataCalled = true
    }
    
    func getCount() -> Int {
        getCountCalled = true
        return 1
    }
    
    func getWord(index: Int) -> String {
        getWordCalled = "Yes"
        return getWordCalled
    }
    
    func deleteWord(index: Int) {
        deleteWordCalled = true
    }
    
}
