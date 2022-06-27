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

class ItemModel: Model<Item> {
    
    var search: NSFetchRequest<Item> = Item.fetchRequest()
    var predicate: NSPredicate?
    var typeCategory: String = "" {
        didSet{
            predicate = NSPredicate(format: "parentCategory.name MATCHES %@", typeCategory)
        }
    }
    
    func load(with request: NSFetchRequest<Item> = Item.fetchRequest()) -> [Item] {
        var itemArray = [Item]()
        do {
            itemArray = try context.fetch(request)
            return itemArray
        } catch {
            print("Error to request Itens from dataBase \(error)")
            return []
        }
        
    }
    
    func listingItemByCategory() -> [Item]{
        search.predicate = predicate
        let itens = load(with: search)
        return itens
    }
    
    func searchByTitle(textSearch: String) -> [Item] {
        let titlePredicate = NSPredicate(format: "title CONTAINS[cd] %@", textSearch)
        search.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [titlePredicate, predicate!])
        search.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        let itens = load(with: search)
        return  itens
    }
}
