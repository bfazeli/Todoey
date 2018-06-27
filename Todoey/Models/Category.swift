//
//  Category.swift
//  Todoey
//
//  Created by Bijan Fazeli on 6/22/18.
//  Copyright © 2018 Fazeli, Bijan. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name = ""
    let items = List<Item>()
}
