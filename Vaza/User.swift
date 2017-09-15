//
//  User.swift
//  Vaza
//
//  Created by Anderson Oliveira on 7/5/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import Foundation

class User: NSObject{
    
    var id: String?
    var name: String?
    var screenName: String?
    var location: String?
    var profileImageUrl: String?
    var profileImageUrlHttps: String?
    var url: String?
    
    
    init(userDictionary: [String: Any]){
        self.id = userDictionary["id"] as? String
        self.name = userDictionary["name"] as? String
        self.screenName = userDictionary["screenName"] as? String
        self.location = userDictionary["location"] as? String
        self.profileImageUrl = userDictionary["profileImageUrl"] as? String
        self.profileImageUrlHttps = userDictionary["profileImageUrlHttps"] as? String
        self.url = userDictionary["url"] as? String
    }

}
