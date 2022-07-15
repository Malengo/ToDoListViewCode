//
//  SearchHistoryDataTests.swift
//  TodoListViewCodeTests
//
//  Created by user on 12/07/22.
//

import XCTest
@testable import TodoListViewCode

class SearchHistoryDataTests: XCTestCase {
    var sut: SearchHistoryData!
    
    override func setUp() {
        super.setUp()
        sut = SearchHistoryData(keyWord: "UnitTest")
    }

    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: "UnitTest")
    }

    func test_getCount_with2Data_shouldReturn2() {
        //Given
        sut.saveData(word: "Test1")
        sut.saveData(word: "Test2")
        
        //When
        let result = sut.getCount()
        
        //Then
        XCTAssertEqual(result, 2)
    }
    
    func test_getWord_withValueAtPosition_shouldReturnTest() {
        //Given
        sut.saveData(word: "Test")
        
        //When
        let result = sut.getWord(index: 0)
        
        //Then
        XCTAssertEqual(result, "Test")
    }
    
    func test_deleteword_withValueAtPosition_shouldReturn0() {
        //Given
        sut.saveData(word: "Test")
        
        //When
        sut.deleteWord(index: 0)
        let result = sut.getCount()
        
        //Then
        XCTAssertEqual(result, 0)
    }
}
