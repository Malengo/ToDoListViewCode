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
        db.collection(dbName).addSnapshotListener { (query, error) in
            guard let documents = query?.documents else {
                print("No Category")
                return
            }
            self.listCategories = documents.compactMap { (queryDocumentSnapshot) -> CategoryFireBase in
                return try! queryDocumentSnapshot.data(as: CategoryFireBase.self
                )}
            self.delegate?.update()
        }
    }
    
    func deleteTableItem(index: IndexPath) {
        let name = listCategories[index.row].name
        listCategories.remove(at: index.row)
        delegate?.update()
        db.collection(dbName).whereField("name", isEqualTo: name).getDocuments() {
            (querySnapshot, err) in
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
        listCategories.append(categoty)
        delegate?.update()
        let _ = try? db.collection(dbName).addDocument(from: categoty)
    }
    
}
