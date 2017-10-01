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
    let urlNoti = URL(string: "http://vazadengue.inf.puc-rio.br/api/poi/?sort=date&size=500")
    let urlNotificationTypes = URL(string: "http://vazadengue.inf.puc-rio.br/api/poi-type")
    
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

}
