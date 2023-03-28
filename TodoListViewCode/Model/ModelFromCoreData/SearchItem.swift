//
//  SearchItem.swift
//  TodoListViewCode
//
//  Created by user on 15/08/22.
//

import UIKit
import CoreData

class SearchItem: SearchItemProtocol {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var predicate: NSPredicate?
    var search: NSFetchRequest<Item> = Item.fetchRequest()
    var items: [Item]?
    
    var category: Category? {
        didSet{
            if let name = category?.name{
                predicate = NSPredicate(format: "parentCategory.name MATCHES %@", name)
            }
        }
    }
    
    func listingItemByCategory() {
        search.predicate = predicate
        items = load(with: search)
    }
    
    func searchByTitle(textSearch: String) {
        let titlePredicate = NSPredicate(format: "title CONTAINS[cd] %@", textSearch)
        guard let predicate = predicate else { return }
        search.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [titlePredicate, predicate])
        search.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
       items = load(with: search)
    }
    
    func load(with request: NSFetchRequest<Item>) -> [Item] {
        do {
            items = try context.fetch(request)
        } catch {
            print("Error to request Itens from dataBase \(error)")
        }
        return items ?? []
    }
    
    func isChecked(index: IndexPath) -> Bool {
        guard let item = items?[index.row] as? Item else { return false}
        return item.isChecked
    }
    
    
}
