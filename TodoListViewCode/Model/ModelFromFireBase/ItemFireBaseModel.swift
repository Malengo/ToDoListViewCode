//
//  ItemFireBaseModel.swift
//  TodoListViewCode
//
//  Created by user on 06/07/22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class ItemFireBaseModel: TableConfigurationProtocol {
    
    private var items: [ItemFireBase] = []
    private let db = Firestore.firestore()
    var delegate: UpdateTableProtocol?
    private let dbName = "category"
    var fieldDb: String = ""
    
    // MARK: - TableConfigurationProtocol
    
    func isEmptyList() -> Bool {
        return items.isEmpty
    }
    
    func currentTextCell(indexPath: IndexPath) -> String {
        return items[indexPath.row].title
    }
    
    func getCount() -> Int {
        return items.count
    }
    
    func getAll() {
        db.collection(dbName).whereField("name", isEqualTo: fieldDb).getDocuments() {
            (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.db.collection(self.dbName).document(document.documentID).collection("items").getDocuments { query, error in
                        guard let documents = query?.documents else {
                            print("No Category")
                            return
                        }
                        self.items = documents.compactMap { (queryDocumentSnapshot) -> ItemFireBase in
                            return try! queryDocumentSnapshot.data(as: ItemFireBase.self
                            )}
                        self.delegate?.update()
                    }
                }
            }
        }
    }
    
    func deleteTableItem(indexPath: IndexPath) {
        print("Ok")
    }
    
    func saveNewItem(item: ItemFireBase) throws {
        items.append(item)
        delegate?.update()
        db.collection(dbName).whereField("name", isEqualTo: fieldDb).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let _ = try? self.db.collection(self.dbName).document(document.documentID).collection("items").addDocument(from: item)
                }
            }
        }
    }
    
    // MARK: - Methods Basic
    func isChecked(indexPath: IndexPath) -> Bool {
        return items[indexPath.row].isChecked
    }
    
    func isEmpty() -> Bool {
        return items.isEmpty
    }
    
    func isCheckedUpdate(indexPath: IndexPath) {        
        let item = items[indexPath.row]
        items[indexPath.row].isChecked = !items[indexPath.row].isChecked
        delegate?.update()
        db.collection(dbName).whereField("name", isEqualTo: fieldDb).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for documento in querySnapshot!.documents {
                    self.db.collection(self.dbName).document(documento.documentID).collection("items").whereField("title", isEqualTo: item.title).getDocuments { query, error in
                        for documents in query!.documents {
                            self.db.collection(self.dbName).document(documento.documentID).collection("items").document(documents.documentID)                               .updateData(["isChecked" : !item.isChecked])
                        }
                    }
                }
            }
        }
    }
}
