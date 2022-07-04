//
//  CategoryModel.swift
//  TodoListViewCode
//
//  Created by user on 28/06/22.
//

import Foundation
import CoreData

class CategoryModel: Model<Category>, TableConfigurationProtocol {
    
    var categories: [Category] = []
    
    func addNewCategory(category: Category) {
        categories.append(category)
    }
    
    func deleteTableItem(index: IndexPath) {
        categories.remove(at: index.row)
    }
    
    func searchByName(name: String) {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        let titlePredicate = NSPredicate(format: "name CONTAINS[cd] %@", name)
        request.predicate = titlePredicate
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let list = (try? context.fetch(request)) ?? []
        categories = list
    }
    
    func getAll() {
        guard let listCategory = read() as? [Category] else { return }
        categories = listCategory
    }
    
    func getCount() -> Int {
        if isEmpty() { getAll() }
        return categories.count
    }
    
    func getTextPosition(indexPath: IndexPath) -> String {
        guard let name = categories[indexPath.row].name else { return "There are no Items in the Category List" }
        return name
    }
    
    func isEmpty() -> Bool {
        return categories.isEmpty
    }
    
    func getCategory(index: IndexPath) -> Category {
        return categories[index.row]
    }
}


