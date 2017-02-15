//
//  DetailViewController.swift
//  CMBTeam
//
//  Created by Buwaneka Galpoththawela on 2/10/17.
//  Copyright © 2017 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    
    var currentProfile = [Profile]()
    
    // Building ImageView and Textview
    
    
    let profileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.frame = CGRect.init(x: 0, y: 64, width:375, height: 300)
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.white
        
        return imageView
    }()
    
    let textDisplay:UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.white
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isEditable = false
        
        return textView
    }()
    
    // Get image from a URL string
    
    func getImage(url:String){
        let imageURL = URL(string: url)!
        
        
        let session = URLSession(configuration: .default)
        
        let downloadImageTask = session.dataTask(with: imageURL) { (data, response, error) in
            
            if let error = error {
                print("Error downloading image: \(error)")
            } else {
                
                
                if let response = response as? HTTPURLResponse {
                    print("Downloaded image with response code \(response.statusCode)")
                    if let imageData = data {
                        self.profileImageView.image = UIImage(data: imageData)!
                        
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        
        downloadImageTask.resume()
        
        
    }
    
    
    
    // Adding views on to the stack
    
    
    
    func setupViews(){
        
        view.addSubview(profileImageView)
        view.addSubview(textDisplay)
        
        
        view.addConstraintsWithFormat(format: "H:|[v0(375)]|", views: profileImageView)
        view.addConstraintsWithFormat(format: "H:|[v0(375)]|", views: textDisplay)
        view.addConstraintsWithFormat(format: "V:|-65-[v0(200)]-400-|", views: profileImageView)
        view.addConstraintsWithFormat(format: "V:|-275-[v0(400)]|", views: textDisplay)
        
        
            }
    
    // Display data on the views
   
    func displayDataOnViews(){
        
        for profile in currentProfile{
            
            getImage(url: profile.avatarURL)
            textDisplay.text = profile.bio
            
            
            let attributedText = NSMutableAttributedString(string:profile.firstName,attributes:[NSFontAttributeName:UIFont.smallSystemFontSize,NSForegroundColorAttributeName:UIColor.blue])
            
            attributedText.append(NSAttributedString(string:" \(profile.lastName!)",attributes:[NSFontAttributeName:UIFont.systemFont(ofSize: 4),NSForegroundColorAttributeName:UIColor.blue]))
            
            navigationItem.title = attributedText.string
            
        }

        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        setupViews()
        displayDataOnViews()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
