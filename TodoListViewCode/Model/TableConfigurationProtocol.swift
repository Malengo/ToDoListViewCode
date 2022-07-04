//
//  ConfigurationTableViewProtocol.swift
//  TodoListViewCode
//
//  Created by user on 04/07/22.
//

import Foundation

protocol TableConfigurationProtocol {
    func isEmpty() -> Bool
    func getTextPosition(indexPath: IndexPath) -> String
    func getCount() -> Int
    func getAll()
    func deleteTableItem(index: IndexPath)
}
