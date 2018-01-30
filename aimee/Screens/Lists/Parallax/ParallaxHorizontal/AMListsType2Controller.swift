//
//  AMListsType2Controller.swift
//  aimee
//
//  Created by Chandrachudh on 29/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

class AMListsType2Controller: UIViewController {

    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var btnBack: UIButton!
    
    let imageDataSource = [#imageLiteral(resourceName: "album20"), #imageLiteral(resourceName: "album12"), #imageLiteral(resourceName: "album13"), #imageLiteral(resourceName: "album14"), #imageLiteral(resourceName: "album15"), #imageLiteral(resourceName: "album16"), #imageLiteral(resourceName: "album17"), #imageLiteral(resourceName: "album18"), #imageLiteral(resourceName: "album19"), #imageLiteral(resourceName: "album11")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent
        view.backgroundColor = UIColor.black
        btnBack.setImage(#imageLiteral(resourceName: "back").withRenderingMode(.alwaysTemplate), for: .normal)
        btnBack.imageView?.tintColor = UIColor.white
        setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupCollectionView() {
        let nib = UINib(nibName: AMListsType2Cell.reuseIdentifier(), bundle: nil)
        myCollectionView.register(nib, forCellWithReuseIdentifier: AMListsType2Cell.reuseIdentifier())
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT+20)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        
        myCollectionView.setCollectionViewLayout(layout, animated: true)
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        myCollectionView.reloadData()
    }
    
    @IBAction func didTapBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension AMListsType2Controller: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AMListsType2Cell.reuseIdentifier(), for: indexPath) as! AMListsType2Cell
        cell.populateCellWith(image: imageDataSource[indexPath.row], title: "")
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let visibleCells = myCollectionView.visibleCells as? [AMListsType2Cell] {
            for parallaxCell in visibleCells {
                let xOffset:CGFloat = ((myCollectionView.contentOffset.x - parallaxCell.frame.origin.x) / (SCREEN_WIDTH+PARALAX_IMAGE_EXTRA_WIDTH)) * PARALAX_OFFSET_SPEED
                parallaxCell.offset(offset: CGPoint(x: xOffset, y: 0.0))
            }
        }
    }
}
