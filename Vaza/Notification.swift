//
//  Notification.swift
//  Vaza
//
//  Created by Anderson Oliveira on 9/17/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import Foundation

class Notification: NSObject{
    
    var id: Int?
    var name: String?
    var fields = [Field]()
    
    init(notificationDictionary: [String: Any]){
        self.id = notificationDictionary["id"] as? Int
        self.name = notificationDictionary["name"] as? String
        
        let allFields = notificationDictionary["fields"] as? [[String: Any]]
        
        for field in allFields!{
            let newField = Field(fieldDictionary: field)
            
            self.fields.append(newField)
        }
    }

    
}
