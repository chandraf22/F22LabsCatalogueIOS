//
//  AMLandingViewCell.swift
//  Catalogue
//
//  Created by Chandrachudh on 19/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

class AMLandingViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblTitle: UILabel!
    
    class func reuseIdentifier()->String {
        return "AMLandingViewCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
