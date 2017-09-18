//
//  ViewController.swift
//  Vaza
//
//  Created by Anderson Oliveira on 7/4/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    var restApiManager = RestApiManager()
    var name = String()
    var fileHandler = FileHandler()
    
    @IBOutlet weak var twitterButton: UIBarButtonItem!
    @IBOutlet weak var heatmapButton: UIBarButtonItem!
    @IBOutlet weak var showNotificationsButton: UIBarButtonItem!
    @IBOutlet weak var notificationButton: UIBarButtonItem!
    @IBOutlet weak var instagramButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 40.727093, longitude: -73.97864, zoom: 1.0)
        mapView.camera = camera
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        
        mapView.isMyLocationEnabled = true

        
    }
    
    func resetButtonColors(){
        self.twitterButton.tintColor = UIColor.white
        self.heatmapButton.tintColor = UIColor.white
        self.showNotificationsButton.tintColor = UIColor.white
        self.notificationButton.tintColor = UIColor.white
        self.instagramButton.tintColor = UIColor.white

    }
    var tappedMarker = GMSMarker()
    //_ mapView: GMSMapView,
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {

        tappedMarker = marker
        
        if marker.userData is Content{
            performSegue(withIdentifier: "tweetDetail", sender: self)
        } else if marker.userData is ContentInstagram{
            performSegue(withIdentifier: "instagramDetail", sender: self)
        } else if marker.userData is ContentNotification{
            performSegue(withIdentifier: "notificationDetail", sender: self)
        }
    
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "tweetDetail"{
            let detailsTweet = segue.destination as! DetailTweetVC

            if let tappedContent = tappedMarker.userData as? Content {
                detailsTweet.userFullNameString = (tappedContent.user?.name!)!
                detailsTweet.userNameString = "@" + (tappedContent.user?.screenName!)!
                detailsTweet.dateString = tappedContent.createdAt!
                detailsTweet.tweetTextString = tappedContent.text!
                detailsTweet.classificationString = tappedContent.retrieveClassificationType()
                detailsTweet.imageUserUrl = (tappedContent.user?.profileImageUrl?.replacingOccurrences(of: "normal", with: "400x400"))!
            }

        }else if segue.identifier == "instagramDetail" {
            let detailsInstagram = segue.destination as! DetailInstagramVC
            
            if let tappedContent = tappedMarker.userData as? ContentInstagram {
                detailsInstagram.userFullNameString = (tappedContent.userInstagram?.fullName!)!
                detailsInstagram.userNameString = "@" + (tappedContent.userInstagram?.username!)!
                detailsInstagram.dateString = (tappedContent.caption?.createdTime)!
                detailsInstagram.instagramTextString = tappedContent.caption!.text!
                detailsInstagram.imageUserUrl = (tappedContent.userInstagram?.profilePictureUrl)!
                detailsInstagram.imagePhotoUrl = (tappedContent.images?.standardResolution?.url)!
            }
        } else if segue.identifier == "notificationDetail" {
            let detailsNotification = segue.destination as! DetailNotificationVC
            
            if let tappedContent = tappedMarker.userData as? ContentNotification{
                if tappedContent.user != nil{
                    detailsNotification.userNameString = (tappedContent.user?.name)!
                }else{
                    detailsNotification.userNameString = "Anônimo"
                }
                
                detailsNotification.publicationDateString = tappedContent.date!
                detailsNotification.notificationTitleString = tappedContent.title!
                detailsNotification.notificationDescriptionString = tappedContent.descriptionContent!
                detailsNotification.classificationString = (tappedContent.type?.name!)!
                
                if tappedContent.pictures != nil && (tappedContent.pictures?.count)! > 0{
                    let imageId = String(describing: tappedContent.pictures![0].id!)
                    
                    detailsNotification.imagePhotoUrl = "http://vazadengue.inf.puc-rio.br/api/picture/" +
                            imageId + "/download"
                }
                
                
                //(tappedContent.user)
                
            }
            
        }
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }

    @IBAction func showTwitterNotifications(_ sender: Any) {
        self.resetButtonColors()
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: 40.727093, longitude: -73.97864)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
//        
//        let marker2 = GMSMarker()
//        marker2.position = CLLocationCoordinate2D(latitude:  25.767368, longitude: -80.18930)
//        marker2.title = "Maceio"
//        marker2.snippet = "Australia"
//        marker2.map = mapView
//        
//        let marker3 = GMSMarker()
//        marker3.position = CLLocationCoordinate2D(latitude:  34.088808, longitude: -118.40612)
//        marker3.title = "Topers"
//        marker3.snippet = "Australia"
//        marker3.map = mapView
        
//        
//        restApiManager.retrieveContent{ (contents) in
//            var myContents = [Content]()
//            myContents = contents
//            
//            print("OI1")
//            DispatchQueue.main.async {
//                print("Main")
//                for content in myContents{
//                    var newMarker = GMSMarker()
//                    newMarker = content.convertToMarker()
//                    print("Key: " + (content.classification?.key)!)
//                    if let key = content.classification?.key{
//                        print ("entrei no " + key)
//                        if key != "NOISE"{
//                            newMarker.map = self.mapView
//                            print("printa")
//                        }
//                        else{
//                            newMarker.map = nil
//                            print("nao foi")
//                        }
//
//                    }
//                   
//                    
//                }
//                print ("Done")
//            }
//        }
        self.mapView.clear()
        var myContents = restApiManager.retrieveContentFromFile()
        
                        for content in myContents{
                            var newMarker = GMSMarker()
                            newMarker = content.convertToMarker()
                            if let key = content.classification?.key{
                                if key != "NOISE"{
                                    newMarker.map = self.mapView
                                }
                                else{
                                    newMarker.map = nil
                                }
        
                            }
        }
        
        self.twitterButton.tintColor = UIColor.init(red: 3.0/255.0, green: 85.0/255.0, blue: 1.0/255.0, alpha: 1.0)
    }
    
    
    @IBAction func showNotifications(_ sender: Any) {
        self.mapView.clear()
        self.resetButtonColors()
        self.showNotificationsButton.tintColor = UIColor.init(red: 3.0/255.0, green: 85.0/255.0, blue: 1.0/255.0, alpha: 1.0)
//        var myNotifications = [ContentNotification]()
//        restApiManager.retrieveNotifications{(notifications) in
//            myNotifications = notifications
//        
//            
//            DispatchQueue.main.async {
//                for notification in myNotifications{
//                    var newMarker = GMSMarker()
//                    newMarker = notification.convertToMarker()
//                    newMarker.map = self.mapView
//
//                }
//            }
//            
//        }
        
        
        var myNotifications = restApiManager.retrieveNotificationsFromFile()
        
        for notification in myNotifications{
                                var newMarker = GMSMarker()
                                newMarker = notification.convertToMarker()
                                newMarker.map = self.mapView
            
                            }
//
        
//        var myContents = [Content]()
//        restApiManager.retrieveContent{ (contents) in
//            myContents = contents
//
//            print("OI1")
//            DispatchQueue.main.async {
//                print("Main")
//                for content in myContents{
//                    var newMarker = GMSMarker()
//                    newMarker = content.convertToMarker()
//                    print("Key: " + (content.classification?.key)!)
//                    if let key = content.classification?.key{
//                        print ("entrei no " + key)
//                        if key != "NOISE"{
//                            newMarker.map = self.mapView
//                            print("printa")
//                        }
//                        else{
//                            newMarker.map = nil
//                            print("nao foi")
//                        }
//                        
//                    }
//                    
//                    
//                }
//                print ("Done")
//            }
//        }
        

    }


     @IBAction func showInstagramNotifications(_ sender: Any) {
        self.resetButtonColors()
        self.instagramButton.tintColor = UIColor.init(red: 3.0/255.0, green: 85.0/255.0, blue: 1.0/255.0, alpha: 1.0)
        self.mapView.clear()
        
        var myNotifications = restApiManager.retrieveInstagramNotificationsFromFile()
        
        for notification in myNotifications{
            var newMarker = GMSMarker()
            newMarker = notification.convertToMarker()
            newMarker.map = self.mapView
            
        }

     }
    
    @IBAction func sendNotification(_ sender: Any) {
        
        
        performSegue(withIdentifier: "sendNotification", sender: self)
        

        
        
        
                var myNotitifications = [Notification]()
                restApiManager.retrieveNotificationOptions{ (notifications) in
                    myNotitifications = notifications
                    
                    DispatchQueue.main.async {

                        for notification in myNotitifications{
                            print (notification.name)
//                            var newMarker = GMSMarker()
//                            newMarker = content.convertToMarker()
//                            print("Key: " + (content.classification?.key)!)
//                            if let key = content.classification?.key{
//                                print ("entrei no " + key)
//                                if key != "NOISE"{
//                                    newMarker.map = self.mapView
//                                    print("printa")
//                                }
//                                else{
//                                    newMarker.map = nil
//                                    print("nao foi")
//                                }
//        
//                            }
                            
                            
                        }
                        print ("Done")
                    }
                }

        
    }
    

}

