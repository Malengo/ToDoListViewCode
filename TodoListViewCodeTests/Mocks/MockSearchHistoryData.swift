//
//  MockSearchHistoryData.swift
//  TodoListViewCodeTests
//
//  Created by user on 20/07/22.
//

import Foundation
@testable import TodoListViewCode

class MockSearchHistoryData: SearchHistoryProtocol {
    
    var list: [String] = []
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
        list.append(word)
    }
    
    func getCount() -> Int {
        getCountCalled = true
        return list.count
    }
    
    func getWord(index: Int) -> String {
        getWordCalled = "Yes"
        return getWordCalled
    }
    
    func deleteWord(index: Int) {
        deleteWordCalled = true
    }
    
}
