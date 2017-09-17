//
//  ContentNotification.swift
//  Vaza
//
//  Created by Anderson Oliveira on 7/8/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import Foundation
import GoogleMaps

class ContentNotification : NSObject {
    
    var id: Int?
    var location: GeoLocation?
    var address: String?
    var title: String?
    var descriptionContent: String?
    var date: String?
    var type: Type?
    var user: User?
    var pictures: [Picture]?
    var upVoteCount: Int?
    var downVoteCount: Int?
    var userVote: Int?
    var published: Bool?
 
    init (contentNotificationDictionary : [String: Any]){
        self.id = contentNotificationDictionary["id"] as? Int
        self.location = GeoLocation(geoLocationDictionary: contentNotificationDictionary["location"] as! [String: Any])
        self.address = contentNotificationDictionary["address"] as? String
        self.title = contentNotificationDictionary["title"] as? String
        self.descriptionContent = contentNotificationDictionary["description"] as? String
        self.date = contentNotificationDictionary["date"] as? String
        self.type = Type(typeDictionary: contentNotificationDictionary["type"] as! [String: Any])
        
        
        let allPictures = contentNotificationDictionary["pictures"] as? [[String: Any]]
        self.pictures = [Picture]()
        
        for newPicture in allPictures!{
            let newContent = Picture(pictureDictionary: newPicture)
            
           self.pictures?.append(newContent)
        }
        
        
        
        self.downVoteCount = contentNotificationDictionary["downVoteCount"] as? Int
        self.upVoteCount = contentNotificationDictionary["upVoteCount"] as? Int
        self.userVote = contentNotificationDictionary["userVote"] as? Int
        self.published = contentNotificationDictionary["published"] as? Bool
    }
    
    func convertToMarker() -> GMSMarker{
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: (self.location?.lat)!, longitude: (self.location?.lng)!)
        marker.title = self.user?.name
        marker.snippet = self.descriptionContent
        marker.userData = self
                //UIImage(named: "house")
     //   let color = UIColor.init(red: 255, green: 255, blue: 0, alpha: 1)
        
        switch self.type?.id {
        case 1?, 2?, 4?, 5?:
            marker.icon = UIImage(named: "red-dot")
// marker.icon = GMSMarker.markerImage(with: .red)
        case 3?:
            marker.icon = UIImage(named: "yellow-dot")
          //  marker.icon = GMSMarker.markerImage(with: color)
        default:
            marker.icon = UIImage(named: "blue-dot")
          //  marker.icon = GMSMarker.markerImage(with: .black)
            
        }
        return marker
    }
    /*
     
     init(contentDictionary: [String: Any]){
     self.id = contentDictionary["id"] as? String
     self.text = contentDictionary["text"] as? String
     self.createdAt = contentDictionary["createdAt"] as? String
     self.geoLocation = GeoLocation(geoLocationDictionary: contentDictionary["geolocation"] as! [String : Any])
     self.user = User(userDictionary: contentDictionary["user"] as! [String: Any])
     self.classification = Classification(classificationDictionary: contentDictionary["classification"] as! [String: Any])
     }
     

     func convertToMarker() -> GMSMarker{
     let marker = GMSMarker()
     marker.position = CLLocationCoordinate2D(latitude: (self.geoLocation?.lat)!, longitude: (self.geoLocation?.lng)!)
     marker.title = self.user?.name
     marker.snippet = self.text
     
     switch classification?.key {
     case "INFORMATIVE"?, "NEWS"?, "RELEVANT"?:
     marker.icon = GMSMarker.markerImage(with: .green)
     case "MOSQUITO_FOCUS"?:
     marker.icon = GMSMarker.markerImage(with: .yellow)
     case "SICKNESS"?:
     marker.icon = GMSMarker.markerImage(with: .red)
     default:
     marker.icon = GMSMarker.markerImage(with: .black)
     
     }
     return marker
     }

 */
}
