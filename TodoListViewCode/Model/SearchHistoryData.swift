//
//  searchHistoryData.swift
//  TodoListViewCode
//
//  Created by user on 30/06/22.
//

import Foundation

struct SearchHistoryData {
    
    private var wordsList: [String] = []
    private let defaults = UserDefaults.standard
    private let keyWord = "SearchWord"
    
    init() {
        wordsList = readData()
    }
    
    mutating func readData() -> [String] {
        if let words = defaults.array(forKey: keyWord) as? [String] {
            self.wordsList = words
        }
        return wordsList
    }
    
    mutating func saveData(word: String) {
        wordsList = readData()
        wordsList.append(word)
        defaults.set(wordsList, forKey: keyWord)
    }
    
    mutating func getWordsCount() -> Int {
        return wordsList.count
    }
    
    mutating func getWord(index: Int) -> String {
        return wordsList[index]
    }
    
    mutating func deleteWord(word: String) {
        for (index, item) in wordsList.enumerated() {
            if item == word {
                wordsList.remove(at: index)
                break
            }
        }
        defaults.set(wordsList, forKey: keyWord)
    }
}
