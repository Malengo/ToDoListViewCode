//
//  CategoryModel.swift
//  TodoListViewCode
//
//  Created by user on 28/06/22.
//

import Foundation
import CoreData

class CategoryModel: Model<Category> {
    
    private var categories: [Category] = []
    
    func addNewCategory(category: Category) {
        categories.append(category)
    }
    
    func deleteCategory(index: IndexPath) {
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
    
    func getAllCategories() {
        guard let listCategory = read() as? [Category] else { return }
        categories = listCategory
    }
    
    func getCategoriesCount() -> Int {
        if isEmpty() { getAllCategories() }
        return categories.count
    }
    
    func getCategoryName(index: Int) -> String {
        guard let name = categories[index].name else { return "There are no Items in the Category List" }
        return name
    }
    
    func isEmpty() -> Bool {
        return categories.isEmpty
    }
    
    func getCategory(index: IndexPath) -> Category {
        return categories[index.row]
    }
}
