//
//  AMAccomplishmentCell.swift
//  Catalogue
//
//  Created by Chandrachudh on 22/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

protocol AMAccomplishmentCellDelegate:class {
    func setCurrentSelectedButtonType(selectedButtonType:SelectedButtonType, indexPath:IndexPath)
}

class AMAccomplishmentCell: UICollectionViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var btnYes: UIButton!
    @IBOutlet weak var btnNo: UIButton!
    
    weak var delegate:AMAccomplishmentCellDelegate?
    
    var indexPath:IndexPath?
    
    class func reuseIdentifier()->String {
        return "AMAccomplishmentCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func prepareView(questionair:Questionair) {
        
        baseView.backgroundColor = questionair.backgroundColor
        baseView.clipsToBounds = true
        baseView.layer.cornerRadius = 16.0
        
        btnNo.clipsToBounds = true
        btnYes.clipsToBounds = true
        btnYes.layer.cornerRadius = 4.0
        btnNo.layer.cornerRadius = 4.0
        
        lblTitle.text = questionair.title
        lblSubTitle.text = questionair.subTitle
        
        btnYes.isSelected = false
        btnNo.isSelected = false
        
        if questionair.selectedButtonType == .noSelected {
            btnNo.isSelected = true
        }
        else if questionair.selectedButtonType == .yesSelected {
            btnYes.isSelected = true
        }
        
        changeButtonSelection(button: btnYes)
        changeButtonSelection(button: btnNo)
        
    
    }
    
    @IBAction func didTapButtonYes(_ sender: Any) {
        btnYes.isSelected = true
        btnNo.isSelected = false
        changeButtonSelection(button: btnYes)
        changeButtonSelection(button: btnNo)
        delegate?.setCurrentSelectedButtonType(selectedButtonType: .yesSelected, indexPath: indexPath!)
    }
    
    @IBAction func didTapButtonNo(_ sender: Any) {
        btnYes.isSelected = false
        btnNo.isSelected = true
        changeButtonSelection(button: btnYes)
        changeButtonSelection(button: btnNo)
        delegate?.setCurrentSelectedButtonType(selectedButtonType: .noSelected, indexPath: indexPath!)
    }
    
    func changeButtonSelection(button:UIButton) {
        button.animateFade(duration: 0.5)
        if button.isSelected {
            button.setTitleColor(UIColor.white, for: .normal)
            button.setTitleColor(UIColor.white, for: .selected)
            button.setTitleColor(UIColor.white, for: .highlighted)
            button.backgroundColor = UIColor.black
        }
        else {
            button.setTitleColor(UIColor.black, for: .normal)
            button.setTitleColor(UIColor.black, for: .selected)
            button.setTitleColor(UIColor.black, for: .highlighted)
            button.backgroundColor = UIColor.white
        }
    }
}
