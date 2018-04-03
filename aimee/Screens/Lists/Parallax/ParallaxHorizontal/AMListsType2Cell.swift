//
//  AMListsType2Cell.swift
//  Catalogue
//
//  Created by Chandrachudh on 29/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

class AMListsType2Cell: UICollectionViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    let imgParalax = UIImageView()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func reuseIdentifier()->String {
        return "AMListsType2Cell"
    }
    
    func populateCellWith(image:UIImage, title:String) {
        
        imgParalax.image = image
        if imgParalax.superview == nil {
            baseView.addSubview(imgParalax)
            imgParalax.contentMode = .scaleAspectFill
            imgParalax.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH+PARALAX_IMAGE_EXTRA_HEIGHT, height: SCREEN_HEIGHT)
            imgParalax.autoresizingMask = [.flexibleHeight]
        }
        bringSubview(toFront: lblTitle)
    }
    
    func offset(offset: CGPoint) {
        imgParalax.frame = imgParalax.bounds.offsetBy(dx: offset.x, dy: offset.y)
    }

}
