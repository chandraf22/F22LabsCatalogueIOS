//
//  AMAppDrawerCell.swift
//  Catalogue
//
//  Created by Chandrachudh on 29/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

class AMAppDrawerCell: UICollectionViewCell {

    @IBOutlet weak var imgIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func reuseIdentifier()->String {
        return "AMAppDrawerCell"
    }

}
