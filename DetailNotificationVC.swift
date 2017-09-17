//
//  DetailNotificationVC.swift
//  Vaza
//
//  Created by Anderson Oliveira on 8/9/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import UIKit

class DetailNotificationVC: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var publicationDate: UILabel!
    @IBOutlet weak var classification: UILabel!
    @IBOutlet weak var notificationTitle: UILabel!
    @IBOutlet weak var notificationImage: UIImageView!
    @IBOutlet weak var notificationDescription: UITextView!
    
    var userNameString = String()
    var publicationDateString = String()
    var classificationString = String()
    var notificationTitleString = String()
    var notificationDescriptionString = String()
    var imagePhotoUrl = String()
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = userNameString
        publicationDate.text = publicationDateString
        classification.text = classificationString
        notificationTitle.text = notificationTitleString
        notificationDescription.text = notificationDescriptionString
        
        if !imagePhotoUrl.isEmpty{
            let urlPhoto = URL(string: imagePhotoUrl)
            do{
                let photo = try Data(contentsOf: urlPhoto!)
                notificationImage.image = UIImage(data: photo)
            } catch {
                notificationImage.image = UIImage(named: "vazaicon")
                
            }
        }else {
            notificationImage.image = UIImage(named: "vazaicon")
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopUp(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
}
