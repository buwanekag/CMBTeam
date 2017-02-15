//
//  TeamViewCell.swift
//  CMBTeam
//
//  Created by Buwaneka Galpoththawela on 2/9/17.
//  Copyright © 2017 Buwaneka Galpoththawela. All rights reserved.
//
import Foundation
import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

class TeamViewCell: UICollectionViewCell {
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle:.white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // Build profileImage,nameLabel and titleLabel
    
    let profileImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.backgroundColor = UIColor.white
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = CGFloat(65)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        
        
        
        return imageView
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.numberOfLines = 1
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name:label.font.fontName,size:12)
        
        
        return label
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = UIColor.darkGray
        label.font = UIFont.boldSystemFont(ofSize: 10)
        
        
        return label
    }()
    
    
    // Adding views to the stack
    
    func setupViews(){
        
        backgroundColor = UIColor.white
        
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(titleLabel)
        
        addConstraintsWithFormat(format: "H:|-20-[v0(130)]-20-|", views: profileImageView)
        addConstraintsWithFormat(format: "H:|-5-[v0(150)]-5-|", views: nameLabel)
        addConstraintsWithFormat(format: "H:|-5-[v0(150)]-5-|", views: titleLabel)
        
        addConstraintsWithFormat(format: "V:|-10-[v0(130)]-5-[v1(15)][v2(20)]-20-|", views: profileImageView,nameLabel,titleLabel)
    }
    
   
    // Display cached image, full name and title on views
    
    var profile: Profile? {
        didSet {
            
            profileImageView.image = nil
            activityIndicator.startAnimating()
            
            if let profileImageURL = profile?.avatarURL{
                
                if let image = imageCache.object(forKey: profileImageURL as AnyObject) as? UIImage {
                    
                    profileImageView.image = image
                    
                    activityIndicator.stopAnimating()
                } else {
                    
                    URLSession.shared.dataTask(with: NSURL(string: profileImageURL)! as URL, completionHandler: { (data, response, error) -> Void in
                        
                        if error != nil {
                            print(error.debugDescription)
                            return
                        }
                        
                        let image = UIImage(data: data!)
        
                        imageCache.setObject(image!, forKey: profileImageURL as AnyObject)
                        
                        DispatchQueue.main.async(execute: { () -> Void in
                            self.profileImageView.image = image
                            self.activityIndicator.stopAnimating()
                        })
                        
                        
                    }).resume()
                    
                }
                
                
            }
            
            setNameAndTitle(firstName: (profile!.firstName),lastName: (profile!.lastName),Title: (profile!.title))
            
            
        }
    }
    
    
    // Display name and title on labels
    
    
    func setNameAndTitle(firstName:String,lastName:String,Title:String){
        let attributedText = NSMutableAttributedString(string:firstName,attributes:[NSFontAttributeName:UIFont.smallSystemFontSize,NSForegroundColorAttributeName:UIColor.blue])
        
        attributedText.append(NSAttributedString(string:" \(lastName)",attributes:[NSFontAttributeName:UIFont.systemFont(ofSize: 4),NSForegroundColorAttributeName:UIColor.blue]))
        
        
        
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineSpacing = 4
        
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: NSMakeRange(0, attributedText.string.characters.count))
        
        
        nameLabel.text = attributedText.string
        titleLabel.text = Title
    }
    
    
    
}
