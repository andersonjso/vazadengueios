//
//  LocationInstagram.swift
//  Vaza
//
//  Created by Anderson Oliveira on 7/11/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import Foundation

class LocationInstagram: NSObject{
    
    var id: Int?
    var name: String?
    var latitude: Double?
    var longitude: Double?
    
    init(locationInstagramDictionary: [String: Any]){
        self.id = locationInstagramDictionary["id"] as? Int
        self.name = locationInstagramDictionary["name"] as? String
        self.latitude = locationInstagramDictionary["latitude"] as? Double
        self.longitude = locationInstagramDictionary["longitude"] as? Double
        
    }

}
