//
//  UserInstagram.swift
//  Vaza
//
//  Created by Anderson Oliveira on 7/11/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import Foundation

class UserInstagram: NSObject {
    
    var id: Int?
    var username: String?
    var fullName: String?
    var profilePictureUrl: String?
    
    init (userInstagramDictionary: [String: Any]){
        self.id = userInstagramDictionary["id"] as? Int
        self.username = userInstagramDictionary["username"] as? String
        self.fullName = userInstagramDictionary["fullName"] as? String
        self.profilePictureUrl = userInstagramDictionary["profilePictureUrl"] as? String

        
    }

}
