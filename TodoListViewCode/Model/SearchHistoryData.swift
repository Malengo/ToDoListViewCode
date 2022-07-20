//
//  searchHistoryData.swift
//  TodoListViewCode
//
//  Created by user on 30/06/22.
//

import Foundation

class SearchHistoryData: SearchHistoryProtocol {
    
    private var wordsList: [String] = []
    private let defaults = UserDefaults.standard
    private let keyWord: String
    
    init(keyWord: String) {
        self.keyWord = keyWord
        wordsList = readData()
    }
    
    func readData() -> [String] {
        if let words = defaults.array(forKey: keyWord) as? [String] {
            wordsList = words
        }
        return wordsList
    }
    
    func saveData(word: String) {
        if wordsList.isEmpty {
            wordsList.append(word)
        } else {
            if !wordsList.contains(word) { wordsList.append(word) }
        }
        defaults.set(wordsList, forKey: keyWord)
    }
    
    func getCount() -> Int {
        return wordsList.count
    }
    
    func getWord(index: Int) -> String {
        return wordsList[index]
    }
    
    func deleteWord(index: Int) {
        wordsList.remove(at: index)
        defaults.set(wordsList, forKey: keyWord)
    }
}
