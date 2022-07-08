//
//  ItemModel.swift
//  Todoey
//
//  Created by user on 15/06/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ItemModel: Model<Item>, TableConfigurationProtocol {
    
    private var items: [Item] = []
    var search: NSFetchRequest<Item> = Item.fetchRequest()
    var predicate: NSPredicate?
    var typeCategory: String = "" {
        didSet{
            predicate = NSPredicate(format: "parentCategory.name MATCHES %@", typeCategory)
        }
    }
    
    func isEmptyList() -> Bool {
        return items.isEmpty
    }
    
    func currentTextCell(indexPath: IndexPath) -> String {
        guard let title = items[indexPath.row].title else { return "There no Items "}
        return title
    }
    
    func getCount() -> Int {
        if isEmptyList() { getAll() }
        return items.count
    }
    
    func getAll() {
        listingItemByCategory()
    }
    
    func updateIsChecked(index: IndexPath) {
        items[index.row].isChecked = !items[index.row].isChecked
        save()
    }
    
    func addNewItem(item: Item) {
        items.append(item)
    }
    
    func deleteTableItem(indexPath: IndexPath) {
        items.remove(at: indexPath.row)
    }
    
    func isChecked(index: IndexPath) -> Bool {
        return items[index.row].isChecked
    }
    
    func load(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            items = try context.fetch(request)
        } catch {
            print("Error to request Itens from dataBase \(error)")
        }
        
    }
    
    func listingItemByCategory() {
        search.predicate = predicate
        load(with: search)
    }
    
    func searchByTitle(textSearch: String) {
        let titlePredicate = NSPredicate(format: "title CONTAINS[cd] %@", textSearch)
        guard let predicate = predicate else { return }
        search.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [titlePredicate, predicate])
        search.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        load(with: search)
    }
}
