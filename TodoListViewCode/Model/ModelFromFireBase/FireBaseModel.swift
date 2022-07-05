//
//  FireBaseModel.swift
//  TodoListViewCode
//
//  Created by user on 05/07/22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol UpdateTableProtocol {
    func update()
}

class FireBaseModel: TableConfigurationProtocol {
    
    private let db = Firestore.firestore()
    private var listCategories: [CategoryFireBase] = []
    private let dbName = "category"
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
        listCategories = []
        db.collection(dbName).getDocuments { query, error in
            if let error = error {
                print(error)
            } else {
                for document in query!.documents {
                    let doc = self.db.collection(self.dbName).document(document.documentID)
                    doc.getDocument(as: CategoryFireBase.self) { result in
                        switch result {
                        case .success(let category):
                            self.listCategories.append(category)
                            self.delegate?.update()
                        case .failure(let error):
                            print("Error decoding category: \(error)")
                        }
                    }
                }
            }
        }
    }
    
    func deleteTableItem(index: IndexPath) {
        let name = listCategories[index.row].name
        listCategories.remove(at: index.row)
        delegate?.update()
        db.collection(dbName).whereField("name", isEqualTo: name)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        document.reference.delete()
                    }
                }
            }
    }
    
    func addItem(categoty: CategoryFireBase) throws {
        db.collection(dbName).addDocument(data: ["name" : categoty.name]) { error in
            if let erro = error {
                print(erro)
            }
        }
        getAll()
    }
    
}
