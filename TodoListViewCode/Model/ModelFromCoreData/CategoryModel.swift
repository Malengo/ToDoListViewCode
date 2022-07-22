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
   
    var list: [Any] = []
    var delegate: UpdateTableProtocol?
    
    func addNewCategory(category: Category) {
        list.append(category)
        delegate?.update()
    }
    
    func deleteTableItem(indexPath: IndexPath) {
        guard let category = list[indexPath.row] as? Category else { return  }
        delete(entity: category)
        list.remove(at: indexPath.row)
        delegate?.update()
    }
    
    func searchByName(name: String) {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        let titlePredicate = NSPredicate(format: "name CONTAINS[cd] %@", name)
        request.predicate = titlePredicate
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        let list = (try? context.fetch(request)) ?? []
        self.list = list
    }
    
    func getAll() {
        guard let listCategory = read() as? [Category] else { return }
        list = listCategory
    }
    
    func getCount() -> Int {
        if isEmptyList() { getAll() }
        return list.count
    }
    
    func currentTextCell(indexPath: IndexPath) -> String {
        guard let category = list[indexPath.row] as? Category, let name = category.name else { return "There are no Items in the Category List" }
        return name
    }
    
    func isEmptyList() -> Bool {
        return list.isEmpty
    }
    
    func getEntity(indexPath: IndexPath) -> AnyObject {
        return list[indexPath.row] as AnyObject
    }
    
    func saveData(data: String) {
        do {
            let category = Category(context: self.context)
            category.name = data
            addNewCategory(category: category)
            try self.context.save()
        } catch {
            fatalError()
        }
    }
}



