//
//  Model.swift
//  TodoListViewCode
//
//  Created by user on 24/06/22.
//

import Foundation
import CoreData
import UIKit
protocol ManagedObject {
    func read() -> [NSManagedObject]
    func delete(entity: NSManagedObject)
}

class Model<U: NSManagedObject>: NSManagedObject, ManagedObject {
    
    var request: NSFetchRequest<U> = NSFetchRequest<U>(entityName:  String(describing: U.self))
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func read() -> [NSManagedObject] {
        var entity = [U]()
        
        do {
            entity = try context.fetch(request)
            return entity
        } catch {
            print("Error to gellAll ")
            return []
        }
    }
    
    func delete(entity: NSManagedObject) {
        context.delete(entity)
        save()
    }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("Error to save data")
        }
    }
    
    
}
