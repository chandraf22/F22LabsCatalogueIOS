//
//  AMInterestsSectionHeader.swift
//  aimee
//
//  Created by Chandrachudh on 19/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

class AMInterestsSectionHeader: UICollectionReusableView {

    @IBOutlet weak var lblTitle: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func reuseIdentifier()->String {
        return "AMInterestsSectionHeader"
    }
    
}
