//
//  AMAccomplishmentsController.swift
//  aimee
//
//  Created by Chandrachudh on 22/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

class AMAccomplishmentsController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    
    
    
    @IBOutlet weak var lcHeaderViewTopSpace: NSLayoutConstraint!
    
    let transitionAnimationDuration:Double = 0.25
    
    
    let dictArray = [
        ["title":"Are you a member of a club", "subtitle": "Scout, band, math or drama club, all your past and present memberships count!"],
        ["title":"Have you done any activity lately?", "subtitle": "Watched a concert, went camping, built a 5-foot lefo tower"],
        ["title":"Have you done any volenteering?", "subtitle": "Past or present, any good deeds that you've done."]
    ]
    
    var dataSource = [Questionair]()
    var shouldAnimate = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
        animateAndShowHeaderView()
        prepareDataSource()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func didTapBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}


extension AMAccomplishmentsController {
    func prepareView() {
        
        let cornerRadius:CGFloat = 24.0
        
        let shapeLayer = CAShapeLayer()
        let shapePath = UIBezierPath.init(roundedRect: CGRect(x:0, y:0, width:SCREEN_WIDTH, height:headerView.frame.height), byRoundingCorners: [.bottomRight, .bottomLeft], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        shapeLayer.path = shapePath.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        headerView.layer.addSublayer(shapeLayer)
        let shadowPath = UIBezierPath.init(roundedRect: CGRect(x:0, y:30, width:SCREEN_WIDTH, height:headerView.frame.height-30), byRoundingCorners: [.bottomRight, .bottomLeft], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        headerView.addShadowWith(shadowPath: shadowPath.cgPath, shadowColor: UIColor.black.cgColor, shadowOpacity: 0.15, shadowRadius: 5.0, shadowOffset: CGSize(width: 0, height: 2))
        
        headerView.bringAllSubViewsToFront()
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
    
    func prepareDataSource() {
        
        for dict in dictArray {
            let q = Questionair()
            q.title = dict["title"]!
            q.subTitle = dict["subtitle"]!
            
            dataSource.append(q)
        }
        
        for i in 0..<dataSource.count {
            if i%3 == 1 {
                dataSource[i].backgroundColor = AMPumpkinOrange
            }
            else if i%3 == 0 {
                dataSource[i].backgroundColor = AMSunYellow
            }
            else {
                dataSource[i].backgroundColor = AMAquaGreen
            }
        }
        
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let nib = UINib.init(nibName: AMAccomplishmentCell.reuseIdentifier(), bundle: nil)
        myCollectionView.register(nib, forCellWithReuseIdentifier: AMAccomplishmentCell.reuseIdentifier())
        
        myCollectionView.contentInset = UIEdgeInsetsMake(0.0, SCREEN_WIDTH - min(331, SCREEN_WIDTH-10), 0, 0.0)
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: min(331, SCREEN_WIDTH-10), height: 224)
        layout.sectionInset = UIEdgeInsetsMake(18, 0, 18, 0)
        layout.minimumLineSpacing = 16.0
        layout.minimumInteritemSpacing = 16.0
        myCollectionView.setCollectionViewLayout(layout, animated: true)
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        DispatchQueue.main.async {
            self.myCollectionView.performBatchUpdates({
                self.myCollectionView.reloadData()
            }, completion: { (finished) in
                self.shouldAnimate = false
            })
        }
    }
}

extension AMAccomplishmentsController : UICollectionViewDelegate, UICollectionViewDataSource, AMAccomplishmentCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AMAccomplishmentCell.reuseIdentifier(), for: indexPath) as! AMAccomplishmentCell
        cell.indexPath = indexPath
        cell.delegate = self
        cell.prepareView(questionair: dataSource[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if shouldAnimate {
            cell.transitionYAnimation(duration: transitionAnimationDuration * Double(indexPath.row + 1))
        }
        
    }
    
    func setCurrentSelectedButtonType(selectedButtonType: SelectedButtonType, indexPath: IndexPath) {
        dataSource[indexPath.row].selectedButtonType = selectedButtonType
        
        var flag = true
        
        for obj in dataSource {
            if obj.selectedButtonType == .noneSelected {
                flag = false
            }
        }
        
        if flag {
            showAlert(message: "We have saved your accomplishments!", cancelTitle: "OK")
        }
    }
}

enum SelectedButtonType {
    case yesSelected
    case noSelected
    case noneSelected
}

class Questionair:NSObject {
    var backgroundColor:UIColor = AMPumpkinOrange
    var title:String = ""
    var subTitle:String = ""
    var selectedButtonType = SelectedButtonType.noneSelected
}
