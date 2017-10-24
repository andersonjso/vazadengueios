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
    var width: Float?
    var height: Float?
    
    init (pictureDictionary: [String: Any]){
        self.id = pictureDictionary["id"] as? Int
        self.fileName = pictureDictionary["fileName"] as? String
        self.date = pictureDictionary["date"] as? String
        
       // if pictureDictionary["user"] != nil{
     //             self.user = User(userDictionary: pictureDictionary["user"] as! [String: Any])
      //  }
        
        self.mimeType = pictureDictionary["mimeType"] as? String
        self.width = pictureDictionary["width"] as? Float
        self.height = pictureDictionary["height"] as? Float
    }
    
    init (fileName: String, mimeType: String, width: Float, height: Float){
        self.fileName = fileName
        self.mimeType = mimeType
        self.width = width
        self.height = height

      //  generateDate()
    }
    
    var jsonRepresentation : [String: Any] {
        let dict = [
            "fileName": fileName,
            "date": generateDate(),
            "mimeType": mimeType,
            "width": width,
            "height": height
            ] as [String : Any]
    
        return dict
    }
    
    func generateDate() -> String{
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        self.date = formatter.string(from: date)
        return formatter.string(from: date)
        
    }
}
