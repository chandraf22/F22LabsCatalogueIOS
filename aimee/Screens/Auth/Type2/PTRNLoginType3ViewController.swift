//
//  PTRNLoginType3ViewController.swift
//  Patterns
//
//  Created by Chandrachudh on 18/08/17.
//  Copyright © 2017 F22Labs. All rights reserved.
//

import UIKit

class PTRNLoginType3ViewController: UIViewController {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnJoin: UIButton!
    @IBOutlet weak var flexibleContentView: UIView!
    @IBOutlet weak var lblContentText: UILabel!
    @IBOutlet weak var pageControlBaseView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    
    let animatingLabelContents = ["Train from\nwherever you\nwant",
                                  "Your coach\nknows the\nbest",
                                  "Keep track\nof your\ntraining"]
    let pageControl = PTRNCustomPageControlType2()
    var currentCollectionViewCellRow:Int = 0
    var isAnimating:Bool = true
    let animationDuration:Double = 1.0 * animationMultiplier
    
    @IBOutlet weak var lcImgBgBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var lcImgBgTopSpace: NSLayoutConstraint!
    
    @IBOutlet weak var imgBg: UIImageView!
    
    func getName() -> String {
        return "Type-1"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        btnBack.setImage(#imageLiteral(resourceName: "back").withRenderingMode(.alwaysTemplate), for: .normal)
        btnBack.imageView?.tintColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.shared.statusBarStyle = .lightContent
        setupPageControl()
        lblContentText.text = animatingLabelContents[0]
        btnLogin.setTitle("", for: .normal)
        btnJoin.setTitle("", for: .normal)
        lcImgBgTopSpace.constant = 100.0
        lcImgBgBottomSpace.constant = -50
        flexibleContentView.alpha = 0.0
        self.view.layoutIfNeeded()
        
        perform(#selector(launchScreenWithAnimation), with: nil, afterDelay: 0.5)
    }
    
    @objc private func launchScreenWithAnimation() {
        
        let duration:Double = 1.0

        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {
            self.lcImgBgTopSpace.constant = 50.0
            self.lcImgBgBottomSpace.constant = 0
            self.view.layoutIfNeeded()
        }) { (finished) in
        }
        
        UIView.animate(withDuration:duration , delay: 0.25, options: .curveEaseOut, animations: {
            self.flexibleContentView.alpha = 1.0
            self.btnLogin.changeTitleFromLeftWithAnimation(newText: "LOGIN", animationDuration: self.animationDuration)
            self.btnJoin.changeTitleFromRightWithAnimation(newText: "JOIN", animationDuration: self.animationDuration)
        }) { (finished) in
            self.perform(#selector(self.startAnimatingLabel), with: nil, afterDelay: 3.0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupPageControl() {
        pageControl.frame = pageControlBaseView.bounds
        pageControlBaseView.addSubview(pageControl)
        pageControl.backgroundColor = .clear
        pageControl.numberOfPages = 3
        pageControl.animationDuration = animationDuration
        pageControl.setSelected(index: 0)
    }
    
    @objc private func startAnimatingLabel() {
        
        if isAnimating {
            currentCollectionViewCellRow = (currentCollectionViewCellRow+1) % animatingLabelContents.count
            
            if currentCollectionViewCellRow == 0 {
                lblContentText.animateAndChangeTextFromLeft(newText: animatingLabelContents[currentCollectionViewCellRow], animationDuration: animationDuration)
            }
            else {
                lblContentText.animateAndChangeTextFromRight(newText: animatingLabelContents[currentCollectionViewCellRow], animationDuration: animationDuration)
            }
            
            pageControl.setSelected(index: currentCollectionViewCellRow)
            
            perform(#selector(startAnimatingLabel), with: nil, afterDelay: animationDuration + 5.0)
        }
    }
    
    private func stopAnimating() {
        isAnimating = false
    }

    @IBAction func didTapbackbutton(_ sender: Any) {
        stopAnimating()
        navigationController?.popViewController(animated: true)
    }
}

extension UILabel {
    func animateAndChangeTextFromRight(newText:String, animationDuration:Double) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        layer.add(animation, forKey: kCATransitionFade)
        animation.type = kCATransitionPush
        animation.subtype = kCATransitionFromRight
        animation.duration = animationDuration
        layer.add(animation, forKey: kCATransitionPush)
        
        text = newText
    }
    
    func animateAndChangeTextFromLeft(newText:String, animationDuration:Double) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        layer.add(animation, forKey: kCATransitionFade)
        animation.type = kCATransitionPush
        animation.subtype = kCATransitionFromLeft
        animation.duration = animationDuration
        layer.add(animation, forKey: kCATransitionPush)
        
        text = newText
    }
}

extension UIButton {
    
    func changeTitleFromLeftWithAnimation(newText:String, animationDuration:Double) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animation.type = kCATransitionPush
        animation.subtype = kCATransitionFromLeft
        animation.duration = animationDuration
        titleLabel?.layer.add(animation, forKey: kCATransitionPush)
        
        setTitle(newText, for: .normal)
    }
    
    func changeTitleFromRightWithAnimation(newText:String, animationDuration:Double) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        animation.type = kCATransitionPush
        animation.subtype = kCATransitionFromRight
        animation.duration = animationDuration
        titleLabel?.layer.add(animation, forKey: kCATransitionPush)
        
        setTitle(newText, for: .normal)
    }
}

