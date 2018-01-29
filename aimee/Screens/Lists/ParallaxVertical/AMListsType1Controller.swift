//
//  AMListsType1Controller.swift
//  aimee
//
//  Created by Chandrachudh on 29/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

class AMListsType1Controller: UIViewController {

    @IBOutlet weak var myCollectionView: UICollectionView!
    
    let imageDataSource = [#imageLiteral(resourceName: "album10"), #imageLiteral(resourceName: "album2"), #imageLiteral(resourceName: "album3"), #imageLiteral(resourceName: "album4"), #imageLiteral(resourceName: "album5"), #imageLiteral(resourceName: "album6"), #imageLiteral(resourceName: "album7"), #imageLiteral(resourceName: "album8"), #imageLiteral(resourceName: "album9"), #imageLiteral(resourceName: "album1")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ScreenType.kParallaxVerticalList.getTitle()
        navigationController?.navigationBar.tintColor = UIColor.black
        
        setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension AMListsType1Controller {
    func setupCollectionView() {
        
        let nib = UINib(nibName: AMListsType1Cell.reuseIdentifier(), bundle: nil)
        myCollectionView.register(nib, forCellWithReuseIdentifier: AMListsType1Cell.reuseIdentifier())
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: SCREEN_WIDTH, height: PARALAX_CELL_HEIGHT)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        myCollectionView.setCollectionViewLayout(layout, animated: true)
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        myCollectionView.reloadData()
    }
}

extension AMListsType1Controller: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AMListsType1Cell.reuseIdentifier(), for: indexPath) as! AMListsType1Cell
        cell.populateCellWith(image: imageDataSource[indexPath.row], title: "")
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let visibleCells = myCollectionView.visibleCells as? [AMListsType1Cell] {
            for parallaxCell in visibleCells {
                let yOffset:CGFloat = ((myCollectionView.contentOffset.y - parallaxCell.frame.origin.y) / (PARALAX_CELL_HEIGHT+PARALAX_IMAGE_EXTRA_HEIGHT)) * PARALAX_OFFSET_SPEED
                parallaxCell.offset(offset: CGPoint(x: 0.0, y: yOffset))
            }
        }
    }
}
