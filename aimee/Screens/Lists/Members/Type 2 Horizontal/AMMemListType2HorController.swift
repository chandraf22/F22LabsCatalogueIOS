//
//  AMMemListType2HorController.swift
//  Catalogue
//
//  Created by Chandrachudh on 01/02/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

class AMMemListType2HorController: UIViewController {

    @IBOutlet weak var topMembersCollectionView: UICollectionView!
    @IBOutlet weak var suggestedMembersCollectionView: UICollectionView!
    
    var topMembersDataSource = [ListUserData]()
    var suggestedMembersDataSource = [ListUserData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topMembersDataSource = getUserListDataSource()
        suggestedMembersDataSource = getUserListDataSource()
        setupCollectionViewTop()
        setupCollectionViewSuggested()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didTapSkipButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}


extension AMMemListType2HorController {
    
    func getItemSize()->CGSize {
        var itemSize = CGSize(width: 166, height: 244)
        if currentDeviceType == .iPhoneX || currentDeviceType == .iPhone6Plus {
            return itemSize
        }
        
        
        
        //ALL THESE BASE VALUES CORRESPONDS TO THE IPHONE X SIZES AS THE ZEPPLINE DESIGN IS BASED ON THAT!
        let baseItemWidth:CGFloat = 166
        let baseItemHeight:CGFloat = 244
        let baseScreenHeight:CGFloat = 812
        let baseScreenWidth:CGFloat = 375
        
        itemSize = CGSize(width: baseItemWidth * SCREEN_WIDTH / baseScreenWidth, height: baseItemHeight * SCREEN_HEIGHT / baseScreenHeight)
        
        return itemSize
    }
    
    func setupCollectionViewTop() {
        
        let nib = UINib(nibName: AMMemListTypw2HorCell.reuseIdentifier(), bundle: nil)
        topMembersCollectionView.register(nib, forCellWithReuseIdentifier: AMMemListTypw2HorCell.reuseIdentifier())
        
        let flowLayout = AMHorizontalCarouselLayout()
        flowLayout.itemSize = getItemSize()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = -70
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 16, 0, flowLayout.itemSize.width)
        flowLayout.delegate = self
        topMembersCollectionView.setCollectionViewLayout(flowLayout, animated: true)
        
        topMembersCollectionView.delegate = self
        topMembersCollectionView.dataSource = self
        topMembersCollectionView.reloadData()
    }
    
    func setupCollectionViewSuggested() {
        
        let nib = UINib(nibName: AMMemListTypw2HorCell.reuseIdentifier(), bundle: nil)
        suggestedMembersCollectionView.register(nib, forCellWithReuseIdentifier: AMMemListTypw2HorCell.reuseIdentifier())
        
        let flowLayout = AMHorizontalCarouselLayout()
        flowLayout.itemSize = getItemSize()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = -70
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 16, 0, flowLayout.itemSize.width)
        flowLayout.delegate = self
        suggestedMembersCollectionView.setCollectionViewLayout(flowLayout, animated: true)
        
        suggestedMembersCollectionView.delegate = self
        suggestedMembersCollectionView.dataSource = self
        suggestedMembersCollectionView.reloadData()
    }
}

extension AMMemListType2HorController: AMHorizontalCarouselLayoutDelegate {
    func getNumberOfSectionsAndRowsFor(collectionView: UICollectionView) -> (sections: Int, rows: Int) {
        if collectionView == topMembersCollectionView {
            return (1,topMembersDataSource.count)
        }
        return (1,suggestedMembersDataSource.count)
    }
    
    func scrollCollectionViewToItemAtIndexPath(indexPath:IndexPath, collectionView:UICollectionView) {
        var proposedOffest = CGPoint.zero
        proposedOffest.x = CGFloat(indexPath.row) * ((collectionView.collectionViewLayout as! AMHorizontalCarouselLayout).itemSize.width + (collectionView.collectionViewLayout as! AMHorizontalCarouselLayout).minimumLineSpacing)
        let newContentOffest = (collectionView.collectionViewLayout as! AMHorizontalCarouselLayout).targetContentOffset(forProposedContentOffset: proposedOffest, withScrollingVelocity: CGPoint.zero)
        collectionView.setContentOffset(newContentOffest, animated: true)
    }
}

extension AMMemListType2HorController: UICollectionViewDelegate, UICollectionViewDataSource, AMMemberToggleSelectionToggleDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (collectionView == topMembersCollectionView) ? topMembersDataSource.count : suggestedMembersDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var userData:ListUserData?
        if collectionView == topMembersCollectionView {
            userData = topMembersDataSource[indexPath.row]
        }
        else {
            userData = suggestedMembersDataSource[indexPath.row]
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AMMemListTypw2HorCell.reuseIdentifier(), for: indexPath) as! AMMemListTypw2HorCell
        cell.myCollectionView = collectionView
        cell.indexPath = indexPath
        cell.delegate = self
        cell.prepareViewWith(userData: userData!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollCollectionViewToItemAtIndexPath(indexPath: indexPath, collectionView: collectionView)
    }
    
    func didToggleConnectionAt(indexPath: IndexPath, collectionView: UICollectionView) {
        if collectionView == topMembersCollectionView {
            topMembersDataSource[indexPath.row].isSelected = !topMembersDataSource[indexPath.row].isSelected
        }
        else {
            suggestedMembersDataSource[indexPath.row].isSelected = !suggestedMembersDataSource[indexPath.row].isSelected
        }
        scrollCollectionViewToItemAtIndexPath(indexPath: indexPath, collectionView: collectionView)
    }
}
