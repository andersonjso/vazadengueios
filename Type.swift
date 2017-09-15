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
    
    init(typeDictionary: [String: Any]){
        self.id = typeDictionary["id"] as? Int
        self.name = typeDictionary["name"] as? String
    }
}
