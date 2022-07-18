//
//  ConfigurationTableViewProtocol.swift
//  TodoListViewCode
//
//  Created by user on 04/07/22.
//

import Foundation

protocol TableConfigurationProtocol {
    var delegate: UpdateTableProtocol? { get set }
    var list: [Any] { get }
    func isEmptyList() -> Bool
    func currentTextCell(indexPath: IndexPath) -> String
    func getCount() -> Int
    func getAll()
    func deleteTableItem(indexPath: IndexPath)
    func getEntity(indexPath: IndexPath) -> AnyObject
    func saveData(data: String)
}
