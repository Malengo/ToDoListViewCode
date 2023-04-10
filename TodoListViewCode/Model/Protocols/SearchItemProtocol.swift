//
//  SearchItemProtocol.swift
//  TodoListViewCode
//
//  Created by user on 15/08/22.
//

import Foundation
import CoreData

protocol SearchItemProtocol {
    var predicate: NSPredicate? { get set }
    var search: NSFetchRequest<Item> { get set }
    var category: Category?  { get set }
    
    func listingItemByCategory()
    func searchByTitle(textSearch: String)
    func load(with request: NSFetchRequest<Item>) -> [Item]
    func isChecked(index: IndexPath) -> Bool
    
}
