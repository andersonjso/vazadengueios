//
//  Type.swift
//  Vaza
//
//  Created by Anderson Oliveira on 7/8/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import Foundation

class Type: NSObject{
    var id: Int?
    var name: String?
    
    var jsonRepresentation : [String : Any] {
        let dict = [
            "id": id,
            "name": name,
        ] as [String : Any]
        
//        let data = try! JSONSerialization.data(withJSONObject: dict, options: [])
//        return String(data: data, encoding:.utf8)!
        
        return dict
    }
    
    init(typeDictionary: [String: Any]){
        self.id = typeDictionary["id"] as? Int
        self.name = typeDictionary["name"] as? String
    }
    
 

}
