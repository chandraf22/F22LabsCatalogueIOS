//
//  AMInterestsViewController.swift
//  aimee
//
//  Created by Chandrachudh on 19/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

class AMInterestsViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnDone: UIButton!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var imgUserAvatar: UIImageView!
    @IBOutlet weak var lblUsername: UILabel!
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var toggleSwitch: UISwitch!
    @IBOutlet weak var lblBtnDoneHighlighter: UILabel!
    
    @IBOutlet weak var lcHeaderViewTopSpace: NSLayoutConstraint!
    
    let dataSource = [
        ["type":"animals & nature.",
         "items":["PETS", "ANIMAL CARE", "WILD LIFE", "FARMING", "GARDENING", "GREEN PEACE", "BLUE CROSS", "NATIONAL PARKS", "SAFARI"]],
        ["type":"arts & crafts.",
         "items":["MUSEUMS", "EXHIBITIONS", "PAINTING", "DANCE", "MUSIC", "INSTRUMENTS", "CERAMICS CRAFTS", "PAPER CRAFTS", "POTTERY", "EMBROIDERY", "KNITTING", "FELTING"]],
        ["type":"books & literature.",
         "items":["SCIENCE FICTION", "DRAMA", "SATIRE", "ACTION AND ADVENTURE", "ROMANCE", "MYSTERY", "HORROR", "GUIDE", "SCIENCE", "COMICS", "ART", "COOKBOOKS", "JOURNALS", "BIOGRAPHIES", "AUTOBIOGRAPHIES", "POETRIES", ]],
        ["type":"animals & nature.",
         "items":["PETS", "ANIMAL CARE", "WILD LIFE", "FARMING", "GARDENING", "GREEN PEACE", "BLUE CROSS", "NATIONAL PARKS", "SAFARI"]],
        ["type":"arts & crafts.",
         "items":["MUSEUMS", "EXHIBITIONS", "PAINTING", "DANCE", "MUSIC", "INSTRUMENTS", "CERAMICS CRAFTS", "PAPER CRAFTS", "POTTERY", "EMBROIDERY", "KNITTING", "FELTING"]],
        ["type":"books & literature.",
         "items":["SCIENCE FICTION", "DRAMA", "SATIRE", "ACTION AND ADVENTURE", "ROMANCE", "MYSTERY", "HORROR", "GUIDE", "SCIENCE", "COMICS", "ART", "COOKBOOKS", "JOURNALS", "BIOGRAPHIES", "AUTOBIOGRAPHIES", "POETRIES", ]],
        ["type":"animals & nature.",
         "items":["PETS", "ANIMAL CARE", "WILD LIFE", "FARMING", "GARDENING", "GREEN PEACE", "BLUE CROSS", "NATIONAL PARKS", "SAFARI"]],
        ["type":"arts & crafts.",
         "items":["MUSEUMS", "EXHIBITIONS", "PAINTING", "DANCE", "MUSIC", "INSTRUMENTS", "CERAMICS CRAFTS", "PAPER CRAFTS", "POTTERY", "EMBROIDERY", "KNITTING", "FELTING"]],
        ["type":"books & literature.",
         "items":["SCIENCE FICTION", "DRAMA", "SATIRE", "ACTION AND ADVENTURE", "ROMANCE", "MYSTERY", "HORROR", "GUIDE", "SCIENCE", "COMICS", "ART", "COOKBOOKS", "JOURNALS", "BIOGRAPHIES", "AUTOBIOGRAPHIES", "POETRIES", ]]
    ]
    
    var objDataSource = [Interests]()
    var objDataSourceDummy = [Interests]()
    
    var shouldAnimate = true
    
    let transitionAnimationDuration:Double = 0.25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpObjDataSource()
        prepareViews()
        animateAndShowHeaderView()
        setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didTapDoneButton(_ sender: Any) {
        
        showAlert(message: "Your interests are saved!", cancelTitle: "OK")
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension AMInterestsViewController {
    
    func setUpObjDataSource() {
        DispatchQueue.main.async {
            self.objDataSource.removeAll()
            self.myCollectionView.reloadData()
            
            for dict in self.dataSource {
                let obj = Interests()
                obj.type = dict["type"] as! String
                
                for item in (dict["items"] as! [String]) {
                    let itemObj = Items()
                    itemObj.name = item
                    obj.items.append(itemObj)
                }
                self.objDataSource.append(obj)
            }
        }
    }
    
    func prepareViews() {
        btnBack.contentHorizontalAlignment = .left
        toggleSwitch.transform = CGAffineTransform.init(scaleX: 0.75, y: 0.75)
        
        let cornerRadius:CGFloat = 24.0
        
        let shapeLayer = CAShapeLayer()
        let shapePath = UIBezierPath.init(roundedRect: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:headerView.frame.height), byRoundingCorners: [.bottomRight, .bottomLeft], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        shapeLayer.path = shapePath.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        headerView.layer.addSublayer(shapeLayer)
        let shadowPath = UIBezierPath.init(roundedRect: CGRect(x:0, y:30, width:SCREEN_WIDTH, height:headerView.frame.height-30), byRoundingCorners: [.bottomRight, .bottomLeft], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        headerView.addShadowWith(shadowPath: shadowPath.cgPath, shadowColor: UIColor.black.cgColor, shadowOpacity: 0.15, shadowRadius: 10.0, shadowOffset: CGSize(width: 0, height: 2))
        
        headerView.bringAllSubViewsToFront()
        
        imgUserAvatar.makeRounded()
        lblUsername.text = "Jhon Doe"
        
        btnDone.disableUserInteraction()
        lblBtnDoneHighlighter.alpha = 0.3
    }
    
    func animateAndShowHeaderView() {
        lcHeaderViewTopSpace.constant = (headerView.frame.maxY + 30) * -1
        view.layoutIfNeeded()
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.75, options: .curveEaseOut, animations: {
                self.lcHeaderViewTopSpace.constant = 0.0
                self.view.layoutIfNeeded()
            }) { (finished) in
            }
        }
    }
    
    func setupCollectionView() {
        DispatchQueue.main.async {
            let cellNib = UINib.init(nibName: AMInterestsCell.reuseIdentifier(), bundle: nil)
            self.myCollectionView.register(cellNib, forCellWithReuseIdentifier: AMInterestsCell.reuseIdentifier())
            
            let sectionHeaderNib = UINib.init(nibName: AMInterestsSectionHeader.reuseIdentifier(), bundle: nil)
            self.myCollectionView.register(sectionHeaderNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: AMInterestsSectionHeader.reuseIdentifier())
            
            self.myCollectionView.contentInset = UIEdgeInsetsMake(50.0, 32, 32, 20.0)
            self.myCollectionView.delegate = self
            self.myCollectionView.dataSource = self
            
            let layout = AMTagLayout.init()
            layout.sectionInset = UIEdgeInsetsMake(20, 0, 50, 0)
            layout.minimumLineSpacing = 10.0
            layout.minimumInteritemSpacing = 13.0
            layout.estimatedItemSize = CGSize(width: 150, height: 44)
            self.myCollectionView.setCollectionViewLayout(layout, animated: false)
            
            self.perform(#selector(self.stopAnimatingAnyMore), with: nil, afterDelay: 1.0)
        }
    }
    
    @objc func stopAnimatingAnyMore() {
        self.shouldAnimate = false
    }
    
    func checkForMinimumInterestsSelection() {
        var selectedItemsCount = 0
        for obj in objDataSource {
            for item in obj.items {
                if item.isSelected {
                    selectedItemsCount += 1
                }
            }
        }
        
        if selectedItemsCount > 2 {
            if btnDone.isUserInteractionEnabled == false {
                lblBtnDoneHighlighter.scaleAndFade(initialAlpha: 0.5)
            }
            btnDone.enableUserInteraction()
        }
        else {
            if btnDone.isUserInteractionEnabled == true {
                lblBtnDoneHighlighter.scaleAndFade(initialAlpha: 1.0)
            }
            btnDone.disableUserInteraction()
        }
    }
}


extension AMInterestsViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return objDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width:SCREEN_WIDTH, height:44.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AMInterestsSectionHeader.reuseIdentifier(), for: indexPath) as! AMInterestsSectionHeader
        headerView.lblTitle.text = objDataSource[indexPath.section].type
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objDataSource[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AMInterestsCell.reuseIdentifier(), for: indexPath) as! AMInterestsCell
        let item = objDataSource[indexPath.section].items[indexPath.row]
        
        cell.prepareView(isSelected: item.isSelected, title: item.name)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if shouldAnimate {
            cell.transitionXAnimation(duration: transitionAnimationDuration * Double(indexPath.section + 1))
        }
        else {
            if toggleSwitch.isOn {
                cell.transitionXAnimation(duration: transitionAnimationDuration/2)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if shouldAnimate {
            view.transitionXAnimation(duration: transitionAnimationDuration * Double(indexPath.section + 1))
        }
        else {
            if toggleSwitch.isOn {
                view.transitionXAnimation(duration: transitionAnimationDuration/2)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        objDataSource[indexPath.section].items[indexPath.row].isSelected = !objDataSource[indexPath.section].items[indexPath.row].isSelected
        
        if let attributes = collectionView.collectionViewLayout.layoutAttributesForSupplementaryView(ofKind: UICollectionElementKindSectionHeader, at: IndexPath(item: 0, section: indexPath.section)) {
            let y = min(attributes.frame.origin.y - collectionView.contentInset.top, (collectionView.contentSize.height - collectionView.frame.height))
            collectionView.setContentOffset(CGPoint(x: collectionView.contentOffset.x, y: y), animated: true)
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! AMInterestsCell
        
        cell.animateFade(duration: 0.5)
        if objDataSource[indexPath.section].items[indexPath.row].isSelected {
            cell.backgroundColor = AMBlack
            cell.lblTitle.textColor = AMWhite2
        }
        else {
            cell.backgroundColor = AMWhite2
            cell.lblTitle.textColor = AMBlack
        }
        checkForMinimumInterestsSelection()
    }
}

class Interests: NSObject {
    var type:String = ""
    var items = [Items]()
}
class Items: NSObject {
    var name:String = ""
    var isSelected:Bool = false
}
