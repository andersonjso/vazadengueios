//
//  GeoLocation.swift
//  Vaza
//
//  Created by Anderson Oliveira on 7/5/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import Foundation

class GeoLocation: NSObject {
    
    var lat: Double?
    var lng: Double?
    
    init(geoLocationDictionary: [String: Any]){
        self.lat = geoLocationDictionary["lat"] as? Double
        self.lng = geoLocationDictionary["lng"] as? Double

    }
}
