//
//  CaptionInstagram.swift
//  Vaza
//
//  Created by Anderson Oliveira on 7/11/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import Foundation

class CaptionInstagram: NSObject {
    
    var id: Int?
    var createdTime: String?
    var text: String?
    
    init(captionInstagramDictionary: [String: Any]){
        self.id = captionInstagramDictionary["id"] as? Int
        self.createdTime = captionInstagramDictionary["createdTime"] as? String
        self.text = captionInstagramDictionary["text"] as? String
    }
}
