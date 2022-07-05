//
//  FireBaseModel.swift
//  TodoListViewCode
//
//  Created by user on 05/07/22.
//

import Foundation
import Firebase

protocol UpdateTableProtocol {
    func update()
}

class FireBaseModel: TableConfigurationProtocol {
    
    private let db = Firestore.firestore()
    private var listCategories: [CategoryFireBase] = []
    var delegate: UpdateTableProtocol?
    
    init() {
        getAll()
    }
    
    func isEmpty() -> Bool {
        return listCategories.isEmpty
    }
    
    func getTextPosition(indexPath: IndexPath) -> String {
        return listCategories[indexPath.row].name
    }
    
    func getCount() -> Int {
        return listCategories.count
    }
    
    func getAll() {
        db.collection("category").getDocuments { query, error in
            if let error = error {
                print(error)
            } else {
                for value in query!.documents {
                    if let name = value.data()["name"] as? String {
                        let category = CategoryFireBase(name: name)
                        self.listCategories.append(category)
                    }
                }
                self.delegate?.update()
            }
        }
    }
    
    func deleteTableItem(index: IndexPath) {
        
    }
    
}
