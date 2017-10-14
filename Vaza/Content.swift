//
//  Content.swift
//  Vaza
//
//  Created by Anderson Oliveira on 7/5/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import Foundation
import GoogleMaps

class Content: NSObject {
    
    var id: String?
    var createdAt: Date?
    var text: String?
    var geoLocation: GeoLocation?
    var user: User?
    var classification: Classification?
    
    init(id: String,
         createdAt: Date,
         text: String,
         geoLocation: GeoLocation,
         user: User,
         classification: Classification){
        self.id = id
        self.createdAt = createdAt
        self.text = text
        self.geoLocation = geoLocation
        self.user = user
        self.classification = classification
    }
    
    init(contentDictionary: [String: Any]){
        self.id = contentDictionary["id"] as? String
        self.text = contentDictionary["text"] as? String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        self.createdAt = dateFormatter.date(from: contentDictionary["createdAt"] as! String)
        self.geoLocation = GeoLocation(geoLocationDictionary: contentDictionary["geolocation"] as! [String : Any])
        self.user = User(userDictionary: contentDictionary["user"] as! [String: Any])
        self.classification = Classification(classificationDictionary: contentDictionary["classification"] as! [String: Any])
    }
    
    func convertToMarker() -> GMSMarker{
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: (self.geoLocation?.lat)!, longitude: (self.geoLocation?.lng)!)
        marker.title = self.user?.name
        marker.snippet = self.text
        marker.userData = self
        
        switch classification?.key {
        case "INFORMATIVE"?, "NEWS"?, "RELEVANT"?:
            marker.icon = UIImage(named: "green-dot")
        case "MOSQUITO_FOCUS"?:
            marker.icon = UIImage(named: "yellow-dot")
        case "SICKNESS"?:
            marker.icon = UIImage(named: "red-dot")
        default:
            marker.icon = UIImage(named: "blue-dot")
            
        }
        return marker
    }
    
    func retrieveClassificationType() -> String{
        switch classification?.key {
        case "INFORMATIVE"?:
            return "Informação"
        case "NEWS"?:
            return "Notícia"
        case "RELEVANT"?:
            return "Relevante"
        case "MOSQUITO_FOCUS"?:
            return "Foco de Mosquito"
        case "SICKNESS"?:
            return "Suspeita de Doença"
        default:
            return ""
        }
    }
    
    func convertToDate (dateString: String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return dateFormatter.date(from: dateString)!
    }
    
    /*
     var styleIconMap = {
     1: "img/markers-google/green-dot.png",
     2: "img/markers-google/purple-dot.png",
     3: "img/markers-google/yellow-dot.png",
     4: "img/markers-google/red-dot.png",
     };
 */
    
}
