//
//  ChecklistItem.swift
//  CheckLists
//
//  Created by Sajjad Patel on 2018-09-29.
//  Copyright © 2018 Sajjad Patel. All rights reserved.
//

import Foundation
import UserNotifications

class ChecklistItem: NSObject, Codable{
    var text = ""
    var checked = false
    var dueDate = Date()
    var shouldRemind = false
    var itemID: Int
    
    init(text: String, checked: Bool) {
        self.text = text
        self.checked = checked
        itemID = DataModel.nextChecklistItemID()
        super.init()
    }
    deinit {
        removeNotification()
    }
    
    func toggleChecked() {
        checked = !checked
    }
    
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
    }
    
    func scheduleNotification() {
        removeNotification()
        if shouldRemind && dueDate > Date() {
            let content = UNMutableNotificationContent()
            content.title = "Reminder:"
            content.body = text
            content.sound = UNNotificationSound.default
            
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.month, .day, .hour, .minute], from: dueDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            let request = UNNotificationRequest(identifier: "\(itemID)", content: content, trigger: trigger)
            
            let center = UNUserNotificationCenter.current()
            center.add(request, withCompletionHandler: nil)
        }
    }
}
