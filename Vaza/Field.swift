//
//  Field.swift
//  Vaza
//
//  Created by Anderson Oliveira on 9/17/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import Foundation


class Field: NSObject{
    
    var id: Int?
    var name: String?
    var helpText: String?
    var required: Bool?
    var type: Type?

    var options = [Option]()
    
    var jsonRepresentation :[String: Any] {
        let dict = [
            "id": id,
            "name": name,
            "helpText": helpText,
            "required": required,
            "type": type?.jsonRepresentation
        ] as [String : Any]
        
//        let data = try! JSONSerialization.data(withJSONObject: dict, options: [])
//        return String(data: data, encoding:.utf8)!
        
        return dict
    }
    
    init(fieldDictionary: [String: Any]){
        self.id = fieldDictionary["id"] as? Int
        self.name = fieldDictionary["name"] as? String
        self.helpText = fieldDictionary["helpText"] as? String
        self.required = fieldDictionary["required"] as? Bool
        self.type = Type(typeDictionary: fieldDictionary["type"] as! [String: Any])
        
        
        
        if fieldDictionary["options"] != nil{
            let allOptions = fieldDictionary["options"] as? [[String: Any]]
        
            for option in allOptions!{
                let newOption = Option(optionDictionary: option)
            
                self.options.append(newOption)
            }
        }
    }
    
    


    
}

class Option: NSObject{
    
    var id: Int?
    var label: String?
    var value: String?
    
    init(optionDictionary: [String: Any]){
        self.id = optionDictionary["id"] as? Int
        self.label = optionDictionary["label"] as? String
        self.value = optionDictionary["value"] as? String
    }

    
}
