//
//  AMMemListTypw2HorCell.swift
//  aimee
//
//  Created by Chandrachudh on 01/02/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

class AMMemListTypw2HorCell: UICollectionViewCell {

    weak var delegate:AMMemberToggleSelectionToggleDelegate?
    weak var myCollectionView:UICollectionView?
    
    var indexPath:IndexPath?
    
    private var isAdded = false

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var lblUserConnections: UILabel!
    @IBOutlet weak var btnAddFriend: UIButton!
    
    @IBOutlet weak var lcImageViewWidth: NSLayoutConstraint!
    @IBOutlet weak var lcLabelsBaseViewCenterY: NSLayoutConstraint!//original value = 10
    
    class func reuseIdentifier()->String {
        return "AMMemListTypw2HorCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepareViewWith(userData:ListUserData) {
        isAdded = userData.isSelected
        baseView.layer.cornerRadius = 6.0
        baseView.clipsToBounds = true
        addShadow()
        
        imgAvatar.image = userData.avatar
        imgAvatar.clipsToBounds = true
        imgAvatar.layer.cornerRadius = lcImageViewWidth.constant/2
        lblUsername.text = userData.firstName + " " + userData.lastName
        lblUserConnections.text = "\(userData.connections)" + " " + "Connections"
        
        setupAddButton()
    }

    func addShadow() {
        let height = (myCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.height
        let width = (myCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout).itemSize.width
        
        addShadowWith(shadowPath: UIBezierPath.init(rect: CGRect(x: 0, y: 0, width: width, height: height)).cgPath, shadowColor: UIColor.black.cgColor, shadowOpacity: 0.2, shadowRadius: 50.0, shadowOffset: CGSize(width: 0, height: 0))
    }
    
    @IBAction func didTapButtonAddFriend(_ sender: Any) {
        delegate?.didToggleConnectionAt!(indexPath: indexPath!, collectionView: myCollectionView!)
        isAdded = !isAdded
        btnAddFriend.animateFade(duration: 0.5)
        setupAddButton()
    }
    
    private func setupAddButton() {
        if isAdded {
            btnAddFriend.setImage(#imageLiteral(resourceName: "AddFriendSelected"), for: .normal)
        }
        else {
            btnAddFriend.setImage(#imageLiteral(resourceName: "AddFriendUnSelected"), for: .normal)
        }
    }
}
