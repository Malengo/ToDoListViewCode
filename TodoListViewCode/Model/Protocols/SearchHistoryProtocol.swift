//
//  SearchHistoryProtocol.swift
//  TodoListViewCode
//
//  Created by user on 20/07/22.
//

import Foundation

protocol SearchHistoryProtocol {
    func readData() -> [String]
    func saveData(word: String)
    func getCount() -> Int
    func getWord(index: Int) -> String
    func deleteWord(index: Int)
}
