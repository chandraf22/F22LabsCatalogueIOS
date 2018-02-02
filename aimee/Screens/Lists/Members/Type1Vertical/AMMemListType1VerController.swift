//
//  AMMemListType1VerController.swift
//  aimee
//
//  Created by Chandrachudh on 30/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

class AMMemListType1VerController: UIViewController {

    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var animationTime:CGFloat = 0.4
    var animatedCellIndexPath = [IndexPath]()
    
    var dataSource = [ListUserData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = getUserListDataSource()
        setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didTapSkipButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}


extension AMMemListType1VerController {
    func setupCollectionView() {
        let nib = UINib(nibName: AMMemListType1VerCell.reuseIdentifier(), bundle: nil)
        myCollectionView.register(nib, forCellWithReuseIdentifier: AMMemListType1VerCell.reuseIdentifier())
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: SCREEN_WIDTH, height: 110)
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 30, 0)
        myCollectionView.setCollectionViewLayout(layout, animated: false)
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.reloadData()
    }
}


extension AMMemListType1VerController:UICollectionViewDelegate, UICollectionViewDataSource, AMMemberToggleSelectionToggleDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AMMemListType1VerCell.reuseIdentifier(), for: indexPath) as! AMMemListType1VerCell
        cell.indexPath = indexPath
        let userDetails = dataSource[indexPath.row]
        cell.isAdded = userDetails.isSelected
        cell.imgAvatar.image = userDetails.avatar
        cell.lblUserName.text = userDetails.firstName + " " + userDetails.lastName
        cell.lblConnections.text = "\(userDetails.connections)" + " " + "Connections"
        cell.prepareView()
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if animatedCellIndexPath.contains(indexPath) == false {
            animatedCellIndexPath.append(indexPath)
            
            let rotateTransform = CATransform3DTranslate(CATransform3DIdentity, -250, 10, 0)
            cell.layer.transform = rotateTransform
            
            UIView.animate(withDuration: TimeInterval(animationTime), animations: {
                cell.layer.transform = CATransform3DIdentity
            }, completion:{(value: Bool) in
                self.animationTime -= 0.1
            })
            animationTime += 0.1
        }
    }
    
    func didToggleConnectionAt(indexPath: IndexPath) {
        dataSource[indexPath.row].isSelected = !dataSource[indexPath.row].isSelected
    }
}
