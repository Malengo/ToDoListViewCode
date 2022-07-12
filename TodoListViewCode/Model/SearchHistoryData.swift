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
    private let keyWord: String?
    
    init(keyWord: String) {
        self.keyWord = keyWord
        wordsList = readData()
    }
    
    mutating func readData() -> [String] {
        guard let keyWord = keyWord else { return [] }
        if let words = defaults.array(forKey: keyWord) as? [String] {
            self.wordsList = words
        }
        return wordsList
    }
    
    mutating func saveData(word: String) {
        guard let keyWord = keyWord else { return }
        if wordsList.isEmpty {
            wordsList.append(word)
        } else {
            if !wordsList.contains(word) { wordsList.append(word) }
        }
        defaults.set(wordsList, forKey: keyWord)
    }
    
    mutating func getCount() -> Int {
        return wordsList.count
    }
    
    mutating func getWord(index: Int) -> String {
        return wordsList[index]
    }
    
    mutating func deleteWord(index: Int) {
        guard let keyWord = keyWord else { return }
        wordsList.remove(at: index)
        defaults.set(wordsList, forKey: keyWord)
    }
}
