//
//  ItemFireBaseModel.swift
//  TodoListViewCode
//
//  Created by user on 06/07/22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class ItemFireBaseModel: CRUDModelProtocol {
       
    var list: [Any] = []
    private let db = Firestore.firestore()
    var delegate: UpdateTableProtocol?
    private let dbName = "category"
    var fieldDb: String = ""
    
    // MARK: - TableConfigurationProtocol
    
    func isEmptyList() -> Bool {
        return list.isEmpty
    }
    
    func currentTextCell(indexPath: IndexPath) -> String {
        guard let itemList = list[indexPath.row] as? ItemFireBase else { return "" }
        return itemList.title
    }
    
    func getCount() -> Int {
        return list.count
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
                        self.list = documents.compactMap { (queryDocumentSnapshot) -> ItemFireBase in
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
        list.append(item)
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
        guard let itemList = list[indexPath.row] as? ItemFireBase else { return false }
        return itemList.isChecked
    }
    
    func isEmpty() -> Bool {
        return list.isEmpty
    }
    
    func isCheckedUpdate(indexPath: IndexPath) {        
        guard var item = list[indexPath.row] as? ItemFireBase else { return }
        item.isChecked = !item.isChecked
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
    func getEntity(indexPath: IndexPath) -> AnyObject {
        return ItemFireBaseModel()
    }
    
    func saveData(data: String) {
    }
    
    func updateIsChecked(index: IndexPath) {
        
    }
}
