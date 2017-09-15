//
//  ImageInstagram.swift
//  Vaza
//
//  Created by Anderson Oliveira on 7/11/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import Foundation

class ImagesInstagram: NSObject{
    
    var id: Int?
    var lowResolution: ImageInstagram?
    var thumbnail: ImageInstagram?
    var standardResolution: ImageInstagram?
    var valid: Bool?
    
    init (imageInstagramDictionary: [String: Any]){
        self.id = imageInstagramDictionary["id"] as? Int
        self.lowResolution = ImageInstagram(imageInstagramDictionary: imageInstagramDictionary["lowResolution"] as! [String: Any])
        self.thumbnail = ImageInstagram(imageInstagramDictionary: imageInstagramDictionary["thumbnail"] as! [String: Any])
        self.standardResolution = ImageInstagram(imageInstagramDictionary: imageInstagramDictionary["standardResolution"] as! [String: Any])
        self.valid = imageInstagramDictionary["valid"] as? Bool
    }
    
}

class ImageInstagram: NSObject{
    var id: Int?
    var url: String?
    var width: Int?
    var height: Int?
    var valid: Bool?

    init (imageInstagramDictionary: [String: Any]){
        self.id = imageInstagramDictionary["id"] as? Int
        self.url = imageInstagramDictionary["url"] as? String
        self.width = imageInstagramDictionary["width"] as? Int
        self.height = imageInstagramDictionary["height"] as? Int
        self.valid = imageInstagramDictionary["valid"] as? Bool
    }
}
