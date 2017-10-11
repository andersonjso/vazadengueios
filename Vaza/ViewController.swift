//
//  ViewController.swift
//  Vaza
//
//  Created by Anderson Oliveira on 7/4/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    var restApiManager = RestApiManager()
    var name = String()
    var fileHandler = FileHandler()
    
    @IBOutlet weak var twitterButton: UIBarButtonItem!
    @IBOutlet weak var heatmapButton: UIBarButtonItem!
    @IBOutlet weak var showNotificationsButton: UIBarButtonItem!
    @IBOutlet weak var notificationButton: UIBarButtonItem!
    @IBOutlet weak var instagramButton: UIBarButtonItem!
    private var heatmapLayer: GMUHeatmapTileLayer!
    let locationManager = CLLocationManager()
    var myNotitifications = [Notification]()
  //  var spinnerView = UIView?.self
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude:  -37.1886, longitude: 145.708, zoom: 0.3)
        mapView.camera = camera
        mapView.settings.myLocationButton = true
        mapView.delegate = self
        
        mapView.isMyLocationEnabled = true
        
        heatmapLayer = GMUHeatmapTileLayer()
        
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        locationManager
      
    
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        var locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
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
            
        } else if segue.identifier == "sendNotification"{
            let newNotification = segue.destination as! NewNotificationVC
            
            
            restApiManager.retrieveNotificationOptions{ (notifications) in
                self.myNotitifications = notifications
                
                DispatchQueue.main.async {
                    
                    for notification in self.myNotitifications{
                 //       print (notification.name)
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
                        newNotification.notificationTypesData.append(notification)
                    
                        
                        
                        
                        for field in notification.fields {
                            var options = [String]()
                            if (field.type?.name == "Number"){
                                for age in 6...110{
                                    options.append(String(age))
                                }
                            }else{
                                for option in field.options{
                                    options.append(option.label!)
                                }
                            }
                            
                            let question = NewNotificationVC.QuestionData(field: field, questionOptions: options)
                            
                            newNotification.tableData.append(question)
                    }

                        
                        
                        
                    }
                    
                    newNotification.notificationTypes.reloadAllComponents()
                    newNotification.tableQuestions.reloadData()
                    //  print (newNotification.notificationTypesData.count)
                    print ("Done")
              
                    
                }
            }
            

           
            
            
        }

        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        // Dispose of any resources that can be recreated.
    }

    @IBAction func showTwitterNotifications(_ sender: Any) {
        self.resetButtonColors()
        self.mapView.clear()
        
        let spinnerView = self.displaySpinner(onView: mapView)

        restApiManager.retrieveContent{ (contents) in
            var myContents = [Content]()
            myContents = contents
            
          //  print("OI1")
            DispatchQueue.main.async {
          //      print("Main")
                for content in myContents{
                    var newMarker = GMSMarker()
                    newMarker = content.convertToMarker()
                //    print("Key: " + (content.classification?.key)!)
                    if let key = content.classification?.key{
                 //       print ("entrei no " + key)
                        if key != "NOISE"{
                            newMarker.map = self.mapView
                         //   print("printa")
                        }
                        else{
                            newMarker.map = nil
                         //   print("nao foi")
                        }

                    }
                   
                    
                }
         //       print ("Done")
                self.removeSpinner(spinner: spinnerView)
            }
        }

//        var myContents = restApiManager.retrieveContentFromFile()
//        
//                        for content in myContents{
//                            var newMarker = GMSMarker()
//                            newMarker = content.convertToMarker()
//                            if let key = content.classification?.key{
//                                if key != "NOISE"{
//                                    newMarker.map = self.mapView
//                                }
//                                else{
//                                    newMarker.map = nil
//                                }
//        
//                            }
//        }
        
        self.twitterButton.tintColor = UIColor.init(red: 3.0/255.0, green: 85.0/255.0, blue: 1.0/255.0, alpha: 1.0)
    }
    
    
    @IBAction func showNotifications(_ sender: Any) {
        self.mapView.clear()
        self.resetButtonColors()
        self.showNotificationsButton.tintColor = UIColor.init(red: 3.0/255.0, green: 85.0/255.0, blue: 1.0/255.0, alpha: 1.0)
        
       
        

        
//        
//        var myNotifications = restApiManager.retrieveNotificationsFromFile()
//        
//        for notification in myNotifications{
//                                var newMarker = GMSMarker()
//                                newMarker = notification.convertToMarker()
//                                newMarker.map = self.mapView
//            
        
//                            }
        
        let spinnerView = self.displaySpinner(onView: mapView)
        
        restApiManager.retrieveNotifications{ (contents) in
            var myContents = [ContentNotification]()
            myContents = contents
            
            //  print("OI1")
            DispatchQueue.main.async {
                //      print("Main")
                for content in myContents{
                    var newMarker = GMSMarker()
                    newMarker = content.convertToMarker()
                    newMarker.map = self.mapView
                    
                }
                
                
            }
            //       print ("Done")
            self.removeSpinner(spinner: spinnerView)
        }



    }


     @IBAction func showInstagramNotifications(_ sender: Any) {
        self.resetButtonColors()
        self.instagramButton.tintColor = UIColor.init(red: 3.0/255.0, green: 85.0/255.0, blue: 1.0/255.0, alpha: 1.0)
        self.mapView.clear()
        
//        var myNotifications = restApiManager.retrieveInstagramNotificationsFromFile()
//        
//        for notification in myNotifications{
//            var newMarker = GMSMarker()
//            newMarker = notification.convertToMarker()
//            newMarker.map = self.mapView
//            
//        }
        
        let spinnerView = self.displaySpinner(onView: mapView)
        
        restApiManager.retrieveContentInstagram{ (contents) in
            var myContents = [ContentInstagram]()
            myContents = contents
            
            //  print("OI1")
            DispatchQueue.main.async {
                //      print("Main")
                for content in myContents{
                                var newMarker = GMSMarker()
                                newMarker = content.convertToMarker()
                                newMarker.map = self.mapView
                    
                    }
                    
                    
                }
                //       print ("Done")
                self.removeSpinner(spinner: spinnerView)
            }
        }
    
    @IBAction func sendNotification(_ sender: Any) {
        
        
        performSegue(withIdentifier: "sendNotification", sender: self)
        

        
        
        

        
    }
    @IBAction func plotHeatMap(_ sender: Any) {
        
        
        self.mapView.clear()
        self.resetButtonColors()
    //    self.showNotificationsButton.tintColor = UIColor.init(red: 3.0/255.0, green: 85.0/255.0, blue: 1.0/255.0, alpha: 1.0)
        
//        var myNotifications = restApiManager.retrieveNotificationsFromFile()
//        var list = [GMUWeightedLatLng]()
//        
//        for notification in myNotifications{
//            let lat = notification.location?.lat
//            let lng = notification.location?.lng
//            
//            let coords = GMUWeightedLatLng(coordinate: CLLocationCoordinate2DMake(lat as! CLLocationDegrees, lng as! CLLocationDegrees), intensity: 1.0)
//            
//            list.append(coords)
//
//            heatmapLayer.weightedData = list
//            heatmapLayer.map = self.mapView
//        }
        
        let spinnerView = self.displaySpinner(onView: mapView)
        
        restApiManager.retrieveNotifications{ (contents) in
            var myContents = [ContentNotification]()
            myContents = contents
            var list = [GMUWeightedLatLng]()
            
            //  print("OI1")
            DispatchQueue.main.async {
                //      print("Main")
                for content in myContents{
                                let lat = content.location?.lat
                                let lng = content.location?.lng
                    
                                let coords = GMUWeightedLatLng(coordinate: CLLocationCoordinate2DMake(lat as! CLLocationDegrees, lng as! CLLocationDegrees), intensity: 1.0)
                    
                                list.append(coords)
                    
                                self.heatmapLayer.weightedData = list
                                self.heatmapLayer.map = self.mapView
                    
                }
                
                
            }
            //       print ("Done")
            self.removeSpinner(spinner: spinnerView)
        }


        

        
        
        
        
        
        
        
        
        
        
        
        
        
        
//
//        var list = [GMUWeightedLatLng]()
//        do {
//            // Get the data: latitude/longitude positions of police stations.
//            if let path = Bundle.main.url(forResource: "police_stations", withExtension: "json") {
//                let data = try Data(contentsOf: path)
//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                if let object = json as? [[String: Any]] {
//                    for item in object {
//                        let lat = item["lat"]
//                        let lng = item["lng"]
//                        let coords = GMUWeightedLatLng(coordinate: CLLocationCoordinate2DMake(lat as! CLLocationDegrees, lng as! CLLocationDegrees), intensity: 1.0)
//                        list.append(coords)
//                    }
//                } else {
//                    print("Could not read the JSON.")
//                }
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//        // Add the latlngs to the heatmap layer.
//        heatmapLayer.weightedData = list
//        heatmapLayer.map = self.mapView

    }
    
    func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    func removeSpinner(spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
    
 
    

}

