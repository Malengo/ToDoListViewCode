//
//  CategoryModel.swift
//  TodoListViewCode
//
//  Created by user on 28/06/22.
//

import Foundation
import CoreData
import UIKit

protocol UpdateTableProtocol {
    func update()
}

class CategoryModel: Model<Category>, TableConfigurationProtocol {
    
    private var categories: [Category] = []
    var delegate: UpdateTableProtocol?
    
    func addNewCategory(category: Category) {
        categories.append(category)
        delegate?.update()
    }
    
    func deleteTableItem(indexPath: IndexPath) {
        categories.remove(at: indexPath.row)
        delegate?.update()
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
        if isEmptyList() { getAll() }
        return categories.count
    }
    
    func currentTextCell(indexPath: IndexPath) -> String {
        guard let name = categories[indexPath.row].name else { return "There are no Items in the Category List" }
        return name
    }
    
    func isEmptyList() -> Bool {
        return categories.isEmpty
    }
    
    func getCategory(index: IndexPath) -> Category {
        return categories[index.row]
    }
    
    func saveCategory(categoryName: String) {
        do {
            let category = Category(context: self.context)
            category.name = categoryName
            addNewCategory(category: category)
            try self.context.save()
        } catch {
            fatalError()
        }
    }
}


