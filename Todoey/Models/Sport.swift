//
//  Sport.swift
//  Todoey
//
//  Created by Bijan Fazeli on 6/11/18.
//  Copyright © 2018 Fazeli, Bijan. All rights reserved.
//

import Foundation

class Sport {
    private var title : String
    private var checked : Bool
    
    init(title:String, checked:Bool = false) {
        self.title = title
        self.checked = checked
    }
    
    func getTitle() -> String {
        return title
    }
    
    func setTitle(title:String) {
        self.title = title
    }
    
    func isChecked() -> Bool {
        return checked
    }
    
    func isChecked(_ checked:Bool) {
        self.checked = checked
    }
}
