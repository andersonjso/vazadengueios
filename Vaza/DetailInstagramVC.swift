//
//  DetailInstagramVC.swift
//  Vaza
//
//  Created by Anderson Oliveira on 7/11/17.
//  Copyright © 2017 Anderson Oliveira. All rights reserved.
//

import UIKit

class DetailInstagramVC: UIViewController {

    @IBOutlet weak var userFullName: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var instagramText: UITextView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var instagramDetail: UIView!
    @IBOutlet weak var instagramPhoto: UIImageView!
    
    var userFullNameString = String()
    var userNameString = String()
    var dateSent = Date()
    var instagramTextString = String()
    var imagePhotoUrl = String()
    var linkPost = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userFullName.text = userFullNameString
        userName.text = userNameString
        date.text = dateToString(dateSent: dateSent)
        instagramText.text = instagramTextString
    
        
        let urlPhoto = URL(string: imagePhotoUrl)
        do{
            let photo = try Data(contentsOf: urlPhoto!)
            instagramPhoto.image = UIImage(data: photo)
        } catch {
            instagramPhoto.image = UIImage(named: "instagram_icon")
            
        }
        
        instagramDetail.layer.cornerRadius = 10
        instagramDetail.layer.masksToBounds = true
        
        userFullName.layer.cornerRadius = 2
        userFullName.layer.masksToBounds = true
        
        instagramText.layer.cornerRadius = 5
        instagramText.layer.masksToBounds = true
        
        instagramPhoto.layer.cornerRadius = 5
        instagramPhoto.layer.masksToBounds = true
        
        background.layer.cornerRadius = 5
        background.layer.masksToBounds = true
        
        closeButton.layer.cornerRadius = 2
        closeButton.layer.masksToBounds = true
    }

    @IBAction func goToInstagram(_ sender: Any) {
        let instagramUrl = URL(string: linkPost)
        
        if UIApplication.shared.canOpenURL(instagramUrl!){
            UIApplication.shared.open(instagramUrl!, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(URL(string: "http://instagram.com/")!, options: [:], completionHandler: nil)
        }
    }


    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func dateToString(dateSent: Date) -> String{
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd/MM/yyyy"
        
        
        return formatter.string(from: dateSent)
    }
}
