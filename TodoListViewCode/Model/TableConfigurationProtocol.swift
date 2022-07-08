//
//  ConfigurationTableViewProtocol.swift
//  TodoListViewCode
//
//  Created by user on 04/07/22.
//

import Foundation

protocol TableConfigurationProtocol {
    func isEmptyList() -> Bool
    func currentTextCell(indexPath: IndexPath) -> String
    func getCount() -> Int
    func getAll()
    func deleteTableItem(indexPath: IndexPath)
}
