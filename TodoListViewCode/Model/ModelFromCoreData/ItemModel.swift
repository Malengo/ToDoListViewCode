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

class ItemModel: Model<Item>, CRUDModelProtocol {
  
    var list: [Any] = []
    private var predicate: NSPredicate?
    var search: NSFetchRequest<Item> = Item.fetchRequest()
    var category: Category?
    var delegate: UpdateTableProtocol?
    
    var typeCategory: String = "" {
        didSet{
            predicate = NSPredicate(format: "parentCategory.name MATCHES %@", typeCategory)
        }
    }
    
    func isEmptyList() -> Bool {
        return list.isEmpty
    }
    
    func currentTextCell(indexPath: IndexPath) -> String {
        guard let item = list[indexPath.row] as? Item, let title = item.title else { return "There are no Items "}
        return title
    }
    
    func getCount() -> Int {
        if isEmptyList() { getAll() }
        return list.count
    }
    
    func getAll() {
        listingItemByCategory()
    }
    
    func updateIsChecked(index: IndexPath) {
        guard let item = list[index.row] as? Item else { return }
            item.isChecked = !item.isChecked
        delegate?.update()
        save()
    }
    
    func addNewItem(item: Item) {
        list.append(item)
        delegate?.update()
    }
    
    func deleteTableItem(indexPath: IndexPath) {
        list.remove(at: indexPath.row)
    }
    
    func isChecked(index: IndexPath) -> Bool {
        guard let item = list[index.row] as? Item else { return false }
        return item.isChecked
    }
    
    func load(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        do {
            list = try context.fetch(request)
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
    
    func saveData(data: String) {
        do {
            let item = Item(context: context)
            item.title = data
            item.parentCategory = category
            try context.save()
            addNewItem(item: item)
        } catch {
           fatalError()
        }
    }
    
    func getEntity(indexPath: IndexPath) -> AnyObject {
        return Item()
    }
}
