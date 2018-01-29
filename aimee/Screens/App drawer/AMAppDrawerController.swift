//
//  AMAppDrawerController.swift
//  aimee
//
//  Created by Chandrachudh on 29/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit
let collectionViewLeastInset:CGFloat = 5.0
var collectionViewMostInset:CGFloat = 60.0

class AMAppDrawerController: UIViewController {

    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewbase: UIView!
    @IBOutlet weak var txtEmojiView: UITextView!

    @IBOutlet weak var lcCollectionBaseBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var lcCollectionViewBaseheight: NSLayoutConstraint!
    
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
        
        var heightValue:CGFloat = 50.0
        switch currentDeviceType {
        case .iPhone5:
            heightValue = 40.0
            collectionViewMostInset = 40.0
            break
        case .iPhone6:
            heightValue = 45.0
            collectionViewMostInset = 50.0
            break
        default:
            heightValue = 50.0
            collectionViewMostInset = 70.0
            break
        }
        
        
        layout.itemSize = CGSize(width: heightValue, height: heightValue)
        lcCollectionViewBaseheight.constant = heightValue
        view.layoutIfNeeded()
        
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
        
        scaleUpTheCollectionView()
        invalidateTimer()
        
        if var currentText = txtEmojiView.text {
            if currentText.count > 0 {
                currentText = currentText + " "
            }
            
            currentText = currentText + textDateSource[indexPath.row]
            
            txtEmojiView.text = currentText
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scaleUpTheCollectionView()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        invalidateTimer()
    }
    
    func scaleUpTheCollectionView() {
        if isScaled == false {
            isScaled = true
            DispatchQueue.main.async {
                self.currentSectionInset = UIEdgeInsets(top: 0, left: collectionViewMostInset, bottom: 0, right: collectionViewMostInset)
                self.myCollectionView.reloadData()
                
                var scaleFactor:CGFloat = 1.5
                
                switch currentDeviceType {
                case .iPhone5:
                    scaleFactor = 1.2
                    break
                case .iPhone6:
                    scaleFactor = 1.3
                    break
                default:
                    scaleFactor = 1.5
                    break
                }
                
                let currentHeight = self.collectionViewbase.frame.height
                let scaledHeight = currentHeight * scaleFactor
                self.lcCollectionBaseBottomSpace.constant = (scaledHeight/4) - 5
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                })
                
                self.collectionViewbase.scaleAnimation(duration: 0.5, scaleBy: scaleFactor)
            }
        }
    }
    
    func invalidateTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: APP_DRAWER_EXITED_STATE_DURATION , target: self, selector: #selector(update), userInfo: nil, repeats: false)
    }
    
    @objc func update() {
        if isScaled {
            isScaled = false
            DispatchQueue.main.async {
                self.collectionViewbase.scaleAnimation(duration: 0.5, scaleBy: 1.0)
                self.currentSectionInset = UIEdgeInsets(top: 0, left: collectionViewLeastInset, bottom: 0, right: collectionViewLeastInset)
                if currentDeviceType == .iPhoneX {//don't know why I have to do this! 😔
                    self.currentSectionInset = UIEdgeInsets(top: 13, left: collectionViewLeastInset, bottom: 0, right: collectionViewLeastInset)
                }
                self.myCollectionView.reloadData()
                
                self.lcCollectionBaseBottomSpace.constant = 0.0
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.layoutIfNeeded()
                }, completion: { (finished) in
                    self.myCollectionView.reloadData()
                })
            }
        }
    }
}
