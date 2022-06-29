//
//  CategoryModel.swift
//  TodoListViewCode
//
//  Created by user on 28/06/22.
//

import Foundation
import CoreData

class CategoryModel: Model<Category> {
    
    func searchByName(name: String) -> [Category] {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        let titlePredicate = NSPredicate(format: "name CONTAINS[cd] %@", name)
        request.predicate = titlePredicate
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let categories = (try? context.fetch(request)) ?? []
        return categories
    }
}
