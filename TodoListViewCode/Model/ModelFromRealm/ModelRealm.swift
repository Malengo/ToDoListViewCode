//
//  ModelRealm.swift
//  Todoey
//
//  Created by user on 20/06/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class ModelRealm<U: Object>{
    
    let realm = try? Realm()
    
    func create(entity: Object) {
        do {
            try realm?.write {
                realm?.add(entity)
            }
        } catch {
            print("Error to add new \(error)")
        }
    }
    
    func read() -> Results<U>? {
        return realm?.objects(U.self)
    }
    
    func delete(entity: Object) {
        do {
            try realm?.write {
                realm?.delete(entity)
            }
        } catch {
            
        }
    }
    
}
