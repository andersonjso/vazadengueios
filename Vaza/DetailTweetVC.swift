//
//  DetailTweetVC.swift
//  Vaza
//
//  Created by Anderson Oliveira on 7/9/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import UIKit
import GoogleMaps

class DetailTweetVC: UIViewController {

    @IBOutlet weak var tweetDetail: UIView!
    
    @IBOutlet weak var imageUserProfile: UIImageView!
    @IBOutlet weak var userFullName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var tweetText: UITextView!
    @IBOutlet weak var classification: UILabel!
//    @IBOutlet weak var sourceRetrieval: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
//    @IBOutlet weak var background: UIView!

    
    var userFullNameString = String()
    var userNameString = String()
    var dateSent = Date()
    var tweetTextString = String()
    var classificationString = String()
    var imageUserProfileLocal = UIImageView()
    var imageUserUrl = String()
    
       override func viewDidLoad() {
        super.viewDidLoad()
        
        userFullName.text = userFullNameString
        userName.text = userNameString
        date.text = dateToString(dateSent: dateSent)
        tweetText.text = tweetTextString
        classification.text = classificationString
        
        
        let url = URL(string: imageUserUrl)
//        do{
        
              // DispatchQueue.main.async {
            do{
             //   let spinnerView = self.displaySpinner(onView: tweetDetail)

                let profileImage = try Data(contentsOf: url!)
                self.imageUserProfile.image = UIImage(data: profileImage)
              //  spinnerView.removeFromSuperview()

            }catch {
                self.imageUserProfile.image = UIImage(named: "twitter-logo2")
                
            }
            
       // }
        
               //        }
        
//        catch {
//            imageUserProfile.image = UIImage(named: "twitter-logo2")
//
//        }
        
        
    
//        imageUserProfile.layer.borderWidth = 3
//        imageUserProfile.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        imageUserProfile.layer.masksToBounds = true
        imageUserProfile.layer.cornerRadius = 25
        imageUserProfile.clipsToBounds = true
        
//        sourceRetrieval.image = UIImage(named: "twitter-logo2")
//        sourceRetrieval.layer.masksToBounds = true
//        sourceRetrieval.layer.cornerRadius = 10
//        sourceRetrieval.clipsToBounds = true
        
        tweetDetail.layer.cornerRadius = 10
        tweetDetail.layer.masksToBounds = true
        tweetDetail.layer.shadowColor = UIColor.black.cgColor
        tweetDetail.layer.shadowOpacity = 1
        tweetDetail.layer.shadowOffset = CGSize.zero
        tweetDetail.layer.shadowRadius = 10
        
        userFullName.layer.cornerRadius = 2
        userFullName.layer.masksToBounds = true
        
        tweetText.layer.cornerRadius = 5
        tweetText.layer.masksToBounds = true
        
//        background.layer.cornerRadius = 5
//        background.layer.masksToBounds = true
        
//        closeButton.layer.cornerRadius = 2
//        closeButton.layer.masksToBounds = true
    }
    
    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
    
    func dateToString(dateSent: Date) -> String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd/MM/yyyy"
        
        
        return formatter.string(from: dateSent)
    }



}
