//
//  Checklist.swift
//  CheckLists
//
//  Created by Sajjad Patel on 2018-10-15.
//  Copyright © 2018 Sajjad Patel. All rights reserved.
//

import UIKit

class Checklist: NSObject, Codable {
    var name = ""
    var items: [ChecklistItem] = []
    var iconName = "No Icon"
    
    init(name: String, iconName: String = "No Icon") {
        self.name = name
    }
    
    func sortItems() {
        items.sort { (item1, item2) -> Bool in
            return item1.dueDate.compare(item2.dueDate) == .orderedAscending
        }
    }
    
    func countUncheckedItems() -> Int {
        var count = 0
        for item in items where !item.checked {
            count += 1
        }
        return count
    }
}
