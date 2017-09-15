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
    @IBOutlet weak var instagramText: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var instagramLogo: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var instagramDetail: UIView!
    @IBOutlet weak var instagramPhoto: UIImageView!
    
    var userFullNameString = String()
    var userNameString = String()
    var dateString = String()
    var instagramTextString = String()
    var imageUserUrl = String()
    var imagePhotoUrl = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userFullName.text = userFullNameString
        userName.text = userNameString
        date.text = dateString
        instagramText.text = instagramTextString
        
        let url = URL(string: imageUserUrl)
        do{
            let myProfileImage = try Data(contentsOf: url!)
            profileImage.image = UIImage(data: myProfileImage)
        } catch {
            profileImage.image = UIImage(named: "instagram-icon")
            
        }
        
        let urlPhoto = URL(string: imagePhotoUrl)
        do{
            let photo = try Data(contentsOf: urlPhoto!)
            instagramPhoto.image = UIImage(data: photo)
        } catch {
            instagramPhoto.image = UIImage(named: "instagram-icon")
            
        }
        
        
        
        
        //imageUserProfile.image = imageUserProfile.image
        profileImage.layer.borderWidth = 3
        profileImage.layer.borderColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 50
        profileImage.clipsToBounds = true
        
        instagramLogo.image = UIImage(named: "instagram-icon")
        instagramLogo.layer.masksToBounds = true
        instagramLogo.layer.cornerRadius = 10
        instagramLogo.clipsToBounds = true
        
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


    @IBAction func closePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        print ("eae")
    }
}
