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
    @IBOutlet weak var background: UIView!
    
    var userNameString = String()
    var publicationDateSent = Date()
    var classificationString = String()
    var notificationTitleString = String()
    var notificationDescriptionString = String()
    var imagePhotoUrl = String()
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = userNameString
        publicationDate.text = dateToString(dateSent: publicationDateSent)
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
        
        notificationDescription.layer.cornerRadius = 10
        notificationDescription.layer.masksToBounds = true
        
        notificationImage.layer.cornerRadius = 5
        notificationImage.layer.masksToBounds = true
        
        background.layer.cornerRadius = 5
        background.layer.masksToBounds = true
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopUp(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    func dateToString(dateSent: Date) -> String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd/MM/yyyy"
        
        
        return formatter.string(from: dateSent)
    }
}
