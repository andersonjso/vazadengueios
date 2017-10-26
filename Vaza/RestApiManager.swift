//
//  RestApiManager.swift
//  Vaza
//
//  Created by Anderson Oliveira on 7/5/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import Foundation
import GoogleMaps

class RestApiManager {
    
    let url = URL(string: "http://vazadengue.inf.puc-rio.br/api/tweet?sort=createdAt,desc&size=100")
    let urlInstagram = URL(string: "http://vazadengue.inf.puc-rio.br/api/instagram?size=100&sort=createdTime,desc&filter=location.latitude!=null")
    let urlNoti = URL(string: "http://vazadengue.inf.puc-rio.br/api/poi/?sort=date&size=500")
    let urlNotificationTypes = URL(string: "http://vazadengue.inf.puc-rio.br/api/poi-type")
    let urlUploadImagem = URL(string: "http://vazadengue.inf.puc-rio.br/api/picture/upload")
    
    let session = URLSession.shared
    var fileHandler = FileHandler ()
    
    func retrieveContent(completionHandler:@escaping ([Content]) -> ()){
        var contents = [Content]()
        
        session.dataTask(with: url!) { (data, response, error) in
            if let data = data{
                do{
                    if let jsonDictionary = try JSONSerialization
                        .jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                        as? [String: AnyObject]{
                    
                    let contentDictionaries = jsonDictionary["content"] as? [[String: Any]]
                    
                        for contentDictionary in contentDictionaries!{
                            let newContent = Content(contentDictionary: contentDictionary)
                            
                            contents.append(newContent)
                            
                        }
                    }
                }catch{
                    print(error)
                    print (response ?? "nada")
                }
            }
            
            completionHandler(contents)
        }.resume()
    }
    
    func retrieveContentInstagram(completionHandler:@escaping ([ContentInstagram]) -> ()){
        var contents = [ContentInstagram]()
        
        session.dataTask(with: urlInstagram!) { (data, response, error) in
            if let data = data{
                do{
                    if let jsonDictionary = try JSONSerialization
                        .jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                        as? [String: AnyObject]{
                        
                        let contentDictionaries = jsonDictionary["content"] as? [[String: Any]]
                        
                        for contentDictionary in contentDictionaries!{
                            let newContent = ContentInstagram(contentInstagramDictionary: contentDictionary)
                            
                            contents.append(newContent)
                            
                        }
                    }
                }catch{
                    print(error)
                    print (response ?? "nada")
                }
            }
            
            completionHandler(contents)
            }.resume()
    }
    
    func retrieveContentFromFile() -> [Content]{
        var contents = [Content]()
        
       
        
        var jsonDictionary = fileHandler.readJson(file: "tweet")
        
        let contentDictionaries = jsonDictionary["content"] as? [[String: Any]]
        
        for contentDictionary in contentDictionaries!{
            let newContent = Content(contentDictionary: contentDictionary)
            
            contents.append(newContent)
            
        }
        
        return contents

    }
    
    func retrieveNotificationsFromFile() -> [ContentNotification]{
        var contents = [ContentNotification]()
        
        var jsonDictionary = fileHandler.readJson(file: "notifications")
        
        let contentDictionaries = jsonDictionary["content"] as? [[String: Any]]
        
        for contentDictionary in contentDictionaries!{
            let newContent = ContentNotification(contentNotificationDictionary: contentDictionary)
            
            contents.append(newContent)
        }
        
        return contents
    }
    
    func retrieveNotifications(completionHandler:@escaping ([ContentNotification]) -> ()){
        var contents = [ContentNotification]()
        
        session.dataTask(with: urlNoti!) { (data, response, error) in
            if let data = data{
                do{
                    if let jsonDictionary = try JSONSerialization
                        .jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                        as? [String: AnyObject]{
                        
                        let contentDictionaries = jsonDictionary["content"] as? [[String: Any]]
                        
                        for contentDictionary in contentDictionaries!{
                            let newContent = ContentNotification(contentNotificationDictionary: contentDictionary)
                            
                            contents.append(newContent)
                            
                        }
                    }
                }catch{
                    print(error)
                    print (response ?? "nada")
                }
            }
            
            completionHandler(contents)
            }.resume()
    }
    
    func retrieveInstagramNotificationsFromFile() -> [ContentInstagram]{
        var contents = [ContentInstagram]()
        
        var jsonDictionary = fileHandler.readJson(file: "instagram")
        
        let contentDictionaries = jsonDictionary["content"] as? [[String: Any]]
        
        for contentDictionary in contentDictionaries!{
            let newContent = ContentInstagram(contentInstagramDictionary: contentDictionary)
            
            contents.append(newContent)
        }
        
        return contents
    }
    
    func retrieveNotificationOptions(completionHandler:@escaping ([Notification]) -> ()){
        var notifications = [Notification]()
        
        
        session.dataTask(with: urlNotificationTypes!) { (data, response, error) in
            if let data = data{
                do{
                    let json = try! JSONSerialization.jsonObject(with: data, options: [])
                    
                        let notificationsDictionaries = json as? [[String: Any]]
                        
                        for notificationDic in notificationsDictionaries!{
                            let newNotification = Notification(notificationDictionary: notificationDic)
                            
                            notifications.append(newNotification)
                            
                        }
                    }
                
            }

            completionHandler(notifications)
            }.resume()
    }
    
    func uploadImage(imageNotification: UIImage, completionHandler:@escaping (Picture) -> ()){
  //      var newPicture = Picture!.self
        let url = URL(string: "http://vazadengue.inf.puc-rio.br/api/picture/upload")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let param = [String:String]()
        
        let boundary = generateBoundaryString()
        
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let imageData = UIImageJPEGRepresentation(imageNotification, 1)
        
        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "file", imageDataKey: imageData! as NSData, boundary: boundary) as Data
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
               completionHandler(Picture(pictureDictionary: responseJSON))
            }
        }
 //       completionHandler(newPicture)
        task.resume()
        
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        let mimetype = "image/jpg"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        
        
        
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }


}
