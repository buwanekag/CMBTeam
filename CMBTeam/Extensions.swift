//
//  Extensions.swift
//  CMBTeam
//
//  Created by Buwaneka Galpoththawela on 2/9/17.
//  Copyright © 2017 Buwaneka Galpoththawela. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
}


extension UIColor {
    
    // Custom gray color used on app.
    class func darkGray() -> UIColor {
        return UIColor(red: 169.0/255.0, green: 169.0/255.0, blue: 169.0/255.0, alpha: 1.0)
    }
}

