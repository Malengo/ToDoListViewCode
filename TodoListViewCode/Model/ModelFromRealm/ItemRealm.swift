//
//  ItemRealm.swift
//  Todoey
//
//  Created by user on 20/06/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class ItemRealm: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    var parentCategory = LinkingObjects(fromType: CategoryRealm.self, property: "items")
}
