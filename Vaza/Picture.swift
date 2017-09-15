//
//  Picture.swift
//  Vaza
//
//  Created by Anderson Oliveira on 7/8/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import Foundation

class Picture : NSObject{
    
    var id: Int?
    var fileName: String?
    var date: String?
    var user: User?
    var mimeType: String?
    var width: Int?
    var height: Int?
    
    init (pictureDictionary: [String: Any]){
        self.id = pictureDictionary["id"] as? Int
        self.fileName = pictureDictionary["fileName"] as? String
        self.date = pictureDictionary["date"] as? String
        self.user = User(userDictionary: pictureDictionary["user"] as! [String: Any])
        self.mimeType = pictureDictionary["mimeType"] as? String
        self.width = pictureDictionary["width"] as? Int
        self.height = pictureDictionary["height"] as? Int
    }
}
