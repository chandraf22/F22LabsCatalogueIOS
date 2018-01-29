//
//  AMAppDrawerController.swift
//  aimee
//
//  Created by Chandrachudh on 29/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit
let collectionViewLeastInset:CGFloat = 5.0
let collectionViewMostInset:CGFloat = 60.0

class AMAppDrawerController: UIViewController {

    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewbase: UIView!
    @IBOutlet weak var txtEmojiView: UITextView!

    var timer:Timer?
    var isScaled = false
    var currentSectionInset = UIEdgeInsets(top: 0, left: collectionViewLeastInset, bottom: 0, right: collectionViewLeastInset)
    
    let dataSource = [#imageLiteral(resourceName: "Emoji1"), #imageLiteral(resourceName: "Emoji2"), #imageLiteral(resourceName: "Emoji3"), #imageLiteral(resourceName: "Emoji4"), #imageLiteral(resourceName: "Emoji5"), #imageLiteral(resourceName: "Emoji6"), #imageLiteral(resourceName: "Emoji7"), #imageLiteral(resourceName: "Emoji8"), #imageLiteral(resourceName: "Emoji9"), #imageLiteral(resourceName: "Emoji10")]
    let textDateSource = ["😃", "😎", "😇", "🤠", "😡", "😲", "😭", "😬", "😈", "😱"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = ScreenType.kAppDrawer.getTitle()
        navigationController?.navigationBar.tintColor = UIColor.black
        
        setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollectionView() {
        let nib = UINib(nibName: AMAppDrawerCell.reuseIdentifier(), bundle: nil)
        myCollectionView.register(nib, forCellWithReuseIdentifier: AMAppDrawerCell.reuseIdentifier())
        
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        layout.sectionInset = currentSectionInset
        self.myCollectionView.setCollectionViewLayout(layout, animated: false)
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        myCollectionView.reloadData()
    }
}

extension AMAppDrawerController:UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AMAppDrawerCell.reuseIdentifier(), for: indexPath) as! AMAppDrawerCell
        cell.imgIcon.image = dataSource[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return currentSectionInset
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if var currentText = txtEmojiView.text {
            if currentText.count > 0 {
                currentText = currentText + " "
            }
            
            currentText = currentText + textDateSource[indexPath.row]
            
            txtEmojiView.text = currentText
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if isScaled == false {
            isScaled = true
            DispatchQueue.main.async {
                self.currentSectionInset = UIEdgeInsets(top: 0, left: collectionViewMostInset, bottom: 0, right: collectionViewMostInset)
                self.myCollectionView.reloadData()
                self.collectionViewbase.scaleAnimation(duration: 0.5, scaleBy: 1.5)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: APP_DRAWER_EXITED_STATE_DURATION , target: self, selector: #selector(update), userInfo: nil, repeats: false)
    }
    
    @objc func update() {
        if isScaled {
            isScaled = false
            DispatchQueue.main.async {
                print("calling update")
                self.currentSectionInset = UIEdgeInsets(top: 0, left: collectionViewLeastInset, bottom: 0, right: collectionViewLeastInset)
                self.myCollectionView.reloadData()
                self.collectionViewbase.scaleAnimation(duration: 0.5, scaleBy: 1.0)
            }
        }
    }
}
