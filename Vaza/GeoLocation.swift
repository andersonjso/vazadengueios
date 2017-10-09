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
    
    init (lat: Double, lng: Double){
        self.lat = lat
        self.lng = lng
    }
    
    var jsonRepresentation : [String: Any] {
        let dict = [
            "lat": lat,
            "lng": lng,
        ] as [String : Any]
        
      //  let data = try! JSONSerialization.data(withJSONObject: dict, options: [])
      //  return String(data: data, encoding:.utf8)!
        
        return dict
    }

}
