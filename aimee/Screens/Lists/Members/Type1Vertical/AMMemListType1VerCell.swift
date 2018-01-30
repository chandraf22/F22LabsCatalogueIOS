//
//  AMMemListType1VerCell.swift
//  aimee
//
//  Created by Chandrachudh on 30/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

protocol AMMemListType1VerCellDelegate:class {
    func didToggleConnectionAt(indexPath:IndexPath)
}

class AMMemListType1VerCell: UICollectionViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblConnections: UILabel!
    
    weak var delegate:AMMemListType1VerCellDelegate?
    
    var indexPath:IndexPath?
    var isAdded = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func reuseIdentifier()->String {
        return "AMMemListType1VerCell"
    }

    func prepareView() {
        baseView.layer.cornerRadius = 6.0
        imgAvatar.layer.cornerRadius = imgAvatar.height/2
        btnAdd.layer.cornerRadius = btnAdd.frame.height/2
        
        baseView.addShadowWith(shadowPath: UIBezierPath.init(roundedRect: CGRect(x:0, y:0, width:SCREEN_WIDTH-32, height:100), cornerRadius: 6.0).cgPath, shadowColor: UIColor.black.cgColor, shadowOpacity: 0.1, shadowRadius: 5.0, shadowOffset: CGSize(width: 0, height: 2))
        
        setupAddButton()
    }
    
    @IBAction func didTapAddButton(_ sender: Any) {
        delegate?.didToggleConnectionAt(indexPath: indexPath!)
        isAdded = !isAdded
        btnAdd.animateFade(duration: 0.5)
        setupAddButton()
    }
    
    private func setupAddButton() {
        if isAdded {
            btnAdd.setImage(#imageLiteral(resourceName: "AddFriendSelected"), for: .normal)
        }
        else {
            btnAdd.setImage(#imageLiteral(resourceName: "AddFriendUnSelected"), for: .normal)
        }
    }
}
