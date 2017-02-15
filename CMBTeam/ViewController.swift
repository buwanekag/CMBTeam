//
//  ViewController.swift
//  CMBTeam
//
//  Created by Buwaneka Galpoththawela on 2/8/17.
//  Copyright © 2017 Buwaneka Galpoththawela. All rights reserved.
//

import UIKit

class TeamViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    
    let dataManager = CMBDataManager()
    let cellId = "cellId"
    
    var profilesArray = [Profile]()
    
    // CollectionView protocols
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return profilesArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TeamViewCell
        teamCell.profile = profilesArray[indexPath.row]
        
        return teamCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: 180, height: 200)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView .deselectItem(at: indexPath, animated: false)
        
        let detailViewController = DetailViewController()
        let profile:Profile =  profilesArray[indexPath.item]
        detailViewController.currentProfile = [profile]
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
  
    // Method run on reciept of JSON data
    
    func dataReceived(){
        profilesArray = dataManager.profilesArray
        collectionView?.reloadData()
        
    }
    
    // Setting up collectionView basics
    
    func setUpCollectionView(){
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(TeamViewCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    
    //MARK: Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.readJson()
        setUpCollectionView()
        
        // Navigation bar setup
       
        navigationItem.title = "Meet The Team"
        
        // Notifications from CMBDataManager
        
        NotificationCenter.default.addObserver(self, selector: #selector(TeamViewController.dataReceived), name: NSNotification.Name(rawValue: "receivedDataFromJSON"), object: nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

