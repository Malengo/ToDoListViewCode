//
//  CategoryRealm.swift
//  Todoey
//
//  Created by user on 20/06/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class CategoryRealm: Object{
   @objc dynamic var name: String = ""
    var items = List<ItemRealm>()
}
