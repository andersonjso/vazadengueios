//
//  PointOfInterest.swift
//  
//
//  Created by Anderson Oliveira on 10/4/17.
//
//

import Foundation


class PointOfInterest: NSObject{
    
    
    var address: String?
    var location: GeoLocation?
    var title: String?
    var descriptionPOI: String?
    var date: Date?
    var type: PoiType?
    var user: User?
    var pictures = [Picture]()
    var fieldValues = [FieldValue]()
    var published: Bool?
    
    
    var fields: Dictionary<String, Dictionary<String, String>> = [:]
    
   
    
    var jsonRepresentation : Data {
        var dict = [
            "address": address,
            "location": location?.jsonRepresentation,
            "title": title,
            "description": descriptionPOI,
            "published": published,
            "type": type?.jsonRepresentation,
            "date": convertDate()
            
        ] as [String : Any]
        
        var myNewDictArray: [[String: Any]] = []
        for field in fieldValues{
            myNewDictArray.append(field.jsonRepresentation)
        }
        dict["fieldValues"] = myNewDictArray
        
        var picturesDictArray: [[String: Any]] = []
        for picture in pictures{
            picturesDictArray.append(picture.jsonRepresentation)
        }
        dict["pictures"] = picturesDictArray
        
        let data = try! JSONSerialization.data(withJSONObject: dict, options: [])
        return data
    }
    

    
    func convertFieldsToDictionary(){
        var myNewDictArray: [[String: Any]] = []
        
        for field in fieldValues{
            myNewDictArray.append(field.jsonRepresentation)
        }
    }
    
    func convertDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        
        return formatter.string(from: date)
        
    }
    
}


class FieldValue: NSObject{
    
    var value: String?
    var field: Field?
    
    init (value: String, field: Field){
        self.value = value
        self.field = field
    }
    
    var jsonRepresentation : [String: Any] {
        let dict = [
            "value": value,
            "field": field?.jsonRepresentation,
        ] as [String : Any]
        
//        let data = try! JSONSerialization.data(withJSONObject: dict, options: [])
//        return String(data: data, encoding:.utf8)!
        
        return dict
    }

    
    
}

class PoiType: NSObject{
    var id: CLong?
    var name: String?
  //  var fields = [Field]()
    
    init (id: CLong, name: String){
        self.id = id
        self.name = name
     //   self.fields.append(contentsOf: fields)
    }
    
    var jsonRepresentation : [String: Any]{
        let dict = [
            "id": id,
            "name": name
        ] as [String : Any]
        
        return dict
    }
    
}






//class Content: NSObject {
//    
//    var id: String?
//    var createdAt: String?
//    var text: String?
//    var geoLocation: GeoLocation?
//    var user: User?
//    var classification: Classification?
//    
//    init(id: String,
//         createdAt: String,
//         text: String,
//         geoLocation: GeoLocation,
//         user: User,
//         classification: Classification){
//        self.id = id
//        self.createdAt = createdAt
//        self.text = text
//        self.geoLocation = geoLocation
//        self.user = user
//        self.classification = classification
//    }
//    
//    init(contentDictionary: [String: Any]){
//        self.id = contentDictionary["id"] as? String
//        self.text = contentDictionary["text"] as? String
//        self.createdAt = contentDictionary["createdAt"] as? String
//        self.geoLocation = GeoLocation(geoLocationDictionary: contentDictionary["geolocation"] as! [String : Any])
//        self.user = User(userDictionary: contentDictionary["user"] as! [String: Any])
//        self.classification = Classification(classificationDictionary: contentDictionary["classification"] as! [String: Any])
//}
