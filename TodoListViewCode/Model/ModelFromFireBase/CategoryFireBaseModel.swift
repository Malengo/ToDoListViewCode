//
//  FireBaseModel.swift
//  TodoListViewCode
//
//  Created by user on 05/07/22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class CategoryFireBaseModel: CRUDModelProtocol {
      
    
    private let db = Firestore.firestore()
    var list: [Any] = []
    private let dbName = "category"
    var delegate: UpdateTableProtocol?
    
    init() {
        getAll()
    }
    
    // MARK: - TableConfiguratonProtocol
    
    func isEmptyList() -> Bool {
        return list.isEmpty
    }
    
    func currentTextCell(indexPath: IndexPath) -> String {
        guard let category = list[indexPath.row] as? CategoryFireBase else { return "Erro" }
        return category.name
    }
    
    func getCount() -> Int {
        return list.count
    }
    
    func getOneCategory(indexPath: IndexPath) -> CategoryFireBase {
        guard let category = list[indexPath.row] as? CategoryFireBase else { return CategoryFireBase(name: "ToDo") }
        return category
    }
    
    // MARK: - Crud Methods
    func addItem(categoty: CategoryFireBase) throws {
        list.append(categoty)
        delegate?.update()
        let _ = try? db.collection(dbName).addDocument(from: categoty)
    }
    
    func getAll() {
        db.collection(dbName).addSnapshotListener { (query, error) in
            guard let documents = query?.documents else {
                print("No Category")
                return
            }
            self.list = documents.compactMap { (queryDocumentSnapshot) -> CategoryFireBase in
                return try! queryDocumentSnapshot.data(as: CategoryFireBase.self
                )}
            self.delegate?.update()
        }
    }
    
    func deleteTableItem(indexPath: IndexPath) {
        let name = currentTextCell(indexPath: indexPath)
        list.remove(at: indexPath.row)
        delegate?.update()
        db.collection(dbName).whereField("name", isEqualTo: name).getDocuments() { (querySnapshot, error) in
            if let err = error {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    document.reference.delete()
                }
            }
        }
    }
    
    func getEntity(indexPath: IndexPath) -> AnyObject {
        return CategoryFireBaseModel()
    }
    
    func saveData(data: String) {
        print("Ok")
    }
    
    func updateIsChecked(index: IndexPath) {
        
    }
}
