//
//  CMBDataManager.swift
//  CMBTeam
//
//  Created by Buwaneka Galpoththawela on 2/8/17.
//  Copyright © 2017 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit

class CMBDataManager: NSObject {
    
    static let sharedInstance = CMBDataManager()
    
    var profilesArray = [Profile]()
    
    
    func readJson() {
        do {
            if let file = Bundle.main.url(forResource: "team", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    
                    print(object)
                } else if let jasonResult = json as? [AnyObject] {
                    for result in jasonResult{
                        
                        let profile = Profile()
                        profile.avatarURL = result["avatar"] as! String
                        profile.firstName = result["firstName"] as! String
                        profile.lastName = result["lastName"] as! String
                        profile.bio = result["bio"] as! String
                        profile.title = result["title"] as! String
                        profile.id = result["id"] as! String
                        
                        profilesArray.append(profile)
                    }
                    
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: Notification.Name(rawValue:"receivedDataFromJSON"), object: nil)
                    }
                    
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
}
