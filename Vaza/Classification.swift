//
//  Classification.swift
//  Vaza
//
//  Created by Anderson Oliveira on 7/5/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import Foundation

class Classification: NSObject{
    
    var id: Int?
    var key: String?
    var label: String?
 //   var description: String?
    
    init(classificationDictionary: [String: Any]){
        self.id = classificationDictionary["id"] as? Int
        self.key = classificationDictionary["key"] as? String
        self.label = classificationDictionary["label"] as? String
    }

    
}
