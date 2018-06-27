//
//  Item.swift
//  Todoey
//
//  Created by Bijan Fazeli on 6/22/18.
//  Copyright © 2018 Fazeli, Bijan. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title = ""
    @objc dynamic var date : Date?
    @objc dynamic var done = false
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
