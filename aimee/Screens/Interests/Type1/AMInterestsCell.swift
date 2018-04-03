//
//  AMInterestsCell.swift
//  Catalogue
//
//  Created by Chandrachudh on 19/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

class AMInterestsCell: UICollectionViewCell {

   
    @IBOutlet weak var lblTitle: UILabel!
    
    
    class func reuseIdentifier()->String {
        return "AMInterestsCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepareView(isSelected:Bool, title:String) {
        lblTitle.text = title
        if isSelected {
            backgroundColor = AMBlack
            lblTitle.textColor = AMWhite2
        }
        else {
            backgroundColor = AMWhite2
            lblTitle.textColor = AMBlack
        }
        layer.cornerRadius = 4.0
        clipsToBounds = true
    }
}
