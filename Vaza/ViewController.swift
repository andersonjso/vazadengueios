//
//  ViewController.swift
//  Vaza
//
//  Created by Anderson Oliveira on 7/4/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate {

    @IBOutlet weak var mapView: GMSMapView!
    var restApiManager = RestApiManager()
    var name = String()
    var fileHandler = FileHandler()

    @IBOutlet weak var searchPlace: UISearchBar!
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
  
        
        searchPlace.delegate = self
        //     searchPlace.endEditing(true)
        let camera = GMSCameraPosition.camera(withLatitude:  -37.1886, longitude: 145.708, zoom: 5)
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
        
      //  let spinnerView = self.displaySpinner(onView: mapView)
        
        if segue.identifier == "tweetDetail"{
            let detailsTweet = segue.destination as! DetailTweetVC

            if let tappedContent = tappedMarker.userData as? Content {
                detailsTweet.userFullNameString = (tappedContent.user?.name!)!
                detailsTweet.userNameString = "@" + (tappedContent.user?.screenName!)!
                detailsTweet.dateSent = tappedContent.createdAt!
                detailsTweet.tweetTextString = tappedContent.text!
                detailsTweet.classificationString = tappedContent.retrieveClassificationType()
                detailsTweet.imageUserUrl = (tappedContent.user?.profileImageUrl?.replacingOccurrences(of: "normal", with: "400x400"))!
            }

        }else if segue.identifier == "instagramDetail" {
            let detailsInstagram = segue.destination as! DetailInstagramVC
            
            if let tappedContent = tappedMarker.userData as? ContentInstagram {
                detailsInstagram.userFullNameString = (tappedContent.userInstagram?.fullName!)!
                detailsInstagram.userNameString = "@" + (tappedContent.userInstagram?.username!)!
                detailsInstagram.dateSent = (tappedContent.caption?.createdTime)!
                detailsInstagram.instagramTextString = tappedContent.caption!.text!
                detailsInstagram.imagePhotoUrl = (tappedContent.images?.standardResolution?.url)!
                detailsInstagram.linkPost = tappedContent.link!
            }
        } else if segue.identifier == "notificationDetail" {
            let detailsNotification = segue.destination as! DetailNotificationVC
        
            
            if let tappedContent = tappedMarker.userData as? ContentNotification{
                if tappedContent.user != nil{
                    detailsNotification.userNameString = (tappedContent.user?.name)!
                }else{
                    detailsNotification.userNameString = "Anônimo"
                }
                
                detailsNotification.publicationDateSent = tappedContent.date!
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
                        newNotification.selectedNotification = newNotification.notificationTypesData[0]

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
                        let cell = newNotification.tableQuestions.dequeueReusableCell(withIdentifier: "questionsCells") as! QuestionsTVCell
                        cell.questionOptions.reloadAllComponents()
                        cell.questionName.text = newNotification.tableData[0].field.name
                        cell.field = newNotification.tableData[0].field
                        cell.questionOptionsData.removeAll()
                        cell.questionOptionsData.append(contentsOf: newNotification.tableData[0].questionOptions)
                        cell.answer = cell.questionOptionsData[0]
                        
                        newNotification.cellsList.append(cell)
                    }
                    
                    newNotification.notificationTypes.reloadAllComponents()
                    newNotification.tableQuestions.reloadData()
                    print ("Done")
                }
            }
        }
        //  self.removeSpinner(spinner: spinnerView)

        
        
        
        
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        var query = searchBar.text
    
      //  query = query?.replacingOccurrences(of: " ", with: "%")
        
        let key = "AIzaSyAhmneckRBdCr7YRI_sbT6JxjfeOe4-BVQ"
        
        
      //  let urlString ="your/url/".addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
        let stringURL = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=" + query! + "&key=" + key
        let url = URL(string: stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        session.dataTask(with: request) {data, response, err in
            let responseString = String(data: data!, encoding: .utf8)
            do {
                let datos = responseString?.data(using: .utf8)
                let json = try JSONSerialization.jsonObject(with: datos!, options: []) as! [String:AnyObject]
                let results = json["results"] as? [[String: Any]]
                
                let result = results![0] as! [String:AnyObject]
                
                let geometry = result["geometry"] as! [String:AnyObject]
                
                let locationJson = geometry["location"] as! [String:Double]
                
                let viewport = geometry["viewport"] as! [String:AnyObject]
                
                let northeastJson = viewport["northeast"] as! [String:Double]
                let southJson = viewport["southwest"] as! [String:Double]

                
                let location = GeoLocation(lat: locationJson["lat"]!, lng: locationJson["lng"]!)
                let locationNortheast = GeoLocation(lat: northeastJson["lat"]!, lng: northeastJson["lng"]!)
                let locationSoutheast = GeoLocation(lat: southJson["lat"]!, lng: southJson["lng"]!)
                
                let northEast = CLLocationCoordinate2D(latitude: locationNortheast.lat!, longitude: locationNortheast.lng!)
                let southwest = CLLocationCoordinate2D(latitude: locationSoutheast.lat!, longitude: locationSoutheast.lng!)
                
                
                let bounds = GMSCoordinateBounds(coordinate: northEast, coordinate: southwest)
                
                print ("lat: " + String(describing: location.lat) + ", long: " + String(describing: location.lng))
                
                DispatchQueue.main.async {
                  //  self.mapView.animate(toZoom: 8)
                    
                    let update = GMSCameraUpdate.fit(bounds)
                  //  self.mapView.moveCamera(update)
                    self.mapView.animate(with: update)
//                
//                    let newLocation = CLLocationCoordinate2D(latitude: location.lat!, longitude: location.lng!)
//                    let newLocationCam = GMSCameraUpdate.setTarget(newLocation)
//                    self.mapView.animate(with: newLocationCam)
                }
            } catch {
                print("error serializing JSON: \(error)")
            }
            
        }.resume()
    }
    
//    if let jsonDictionary = try JSONSerialization
//        .jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//        as? [String: AnyObject]{
//        
//        let contentDictionaries = jsonDictionary["content"] as? [[String: Any]]
//        
//        for contentDictionary in contentDictionaries!{
//            let newContent = Content(contentDictionary: contentDictionary)
//            
//            contents.append(newContent)
//            
//        }

    
 
    

}



