//
//  ContentInstagram.swift
//  Vaza
//
//  Created by Anderson Oliveira on 7/11/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import Foundation
import GoogleMaps

class ContentInstagram: NSObject {
    
    var id: String?
    var type: String?
    var filter: String?
    var link: String?
    var caption: CaptionInstagram?
    var userInstagram: UserInstagram?
    var createdTime: String?
    var images: ImagesInstagram?
    var videos: String?
    var location: LocationInstagram?
    var valid: Bool?
    
    init (contentInstagramDictionary: [String: Any]){
        self.id = contentInstagramDictionary["id"] as? String
        self.type = contentInstagramDictionary["type"] as? String
        self.filter = contentInstagramDictionary["filter"] as? String
        self.link = contentInstagramDictionary["link"] as? String
        self.caption = CaptionInstagram(captionInstagramDictionary: contentInstagramDictionary["caption"] as! [String: Any])
        self.userInstagram = UserInstagram(userInstagramDictionary: contentInstagramDictionary["user"] as! [String: Any])
        self.createdTime = contentInstagramDictionary["createdTime"] as? String
        self.images = ImagesInstagram(imageInstagramDictionary: contentInstagramDictionary["images"] as! [String: Any])
        self.videos = nil
        self.location = LocationInstagram(locationInstagramDictionary: contentInstagramDictionary["location"] as! [String: Any])
        self.valid = contentInstagramDictionary["valid"] as? Bool
    }
    
    func convertToMarker() -> GMSMarker{
        let marker = GMSMarker()
        
        marker.position = CLLocationCoordinate2D(latitude: (self.location?.latitude)!, longitude: (self.location?.longitude)!)
        marker.title = self.userInstagram?.fullName
        marker.snippet = self.caption?.text
        marker.userData = self
        marker.icon = UIImage(named: "blue-dot")
        
        return marker
    }

    
    
    
    
    
       
    
    
}
