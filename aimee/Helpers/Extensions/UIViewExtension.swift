//
//  UIViewExtension.swift
//  aimee
//
//  Created by Chandrachudh on 18/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func animateFade(duration:Double) {
        DispatchQueue.main.async {
            let animation = CATransition()
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            animation.type = kCATransitionFade
            animation.duration = duration
            self.layer.add(animation, forKey: "kCATransitionFade")
        }
    }
    
    func animateFromBottom(duration:Double) {
        DispatchQueue.main.async {
            let animation = CATransition()
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            animation.type = kCATransitionMoveIn
            animation.subtype = kCATransitionFromBottom
            animation.duration = duration
            self.layer.add(animation, forKey: "kCATransitionFromBottom")
        }
    }
    
    func scaleAndFade(initialAlpha:CGFloat) {
        DispatchQueue.main.async {
            let animationX = CABasicAnimation.init(keyPath: "transform.scale.x")
            animationX.toValue = 1.5
            animationX.fromValue = 1.0
            animationX.duration = 0.5
            animationX.isRemovedOnCompletion = false
            animationX.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
            animationX.fillMode = kCAFillModeForwards
            self.layer.add(animationX, forKey: "scaleXAnimation")
            
            let animationY = CABasicAnimation.init(keyPath: "transform.scale.y")
            animationY.toValue = 1.5
            animationY.fromValue = 1.0
            animationY.duration = 0.5
            animationY.isRemovedOnCompletion = false
            animationY.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
            animationY.fillMode = kCAFillModeForwards
            self.layer.add(animationY, forKey: "scaleYAnimation")
            
            self.alpha = initialAlpha
            UIView.animate(withDuration: 0.5, animations: {
                self.alpha = 0.0
            }) { (finished) in
            }
        }
    }
    
    func transitionXAnimation(duration:Double) {
        DispatchQueue.main.async {
            let animation = CABasicAnimation.init(keyPath: "transform.translation.x")
            animation.toValue = 0.0
            animation.fromValue = SCREEN_WIDTH
            animation.duration = duration
            animation.isRemovedOnCompletion = false
            animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
            animation.fillMode = kCAFillModeForwards
            self.layer.add(animation, forKey: "transitionXAnimation")
            
            self.alpha = 0.0
            UIView.animate(withDuration: duration, animations: {
                self.alpha = 1.0
            }) { (finished) in
            }
        }
    }
    
    func transitionYAnimation(duration:Double) {
        DispatchQueue.main.async {
            let animation = CABasicAnimation.init(keyPath: "transform.translation.y")
            animation.toValue = 0.0
            animation.fromValue = SCREEN_HEIGHT
            animation.duration = duration
            animation.isRemovedOnCompletion = false
            animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
            animation.fillMode = kCAFillModeForwards
            self.layer.add(animation, forKey: "transitionYAnimation")
            
            self.alpha = 0.0
            UIView.animate(withDuration: duration, animations: {
                self.alpha = 1.0
            }) { (finished) in
            }
        }
    }
    
    func addShadowWith(shadowPath:CGPath, shadowColor:CGColor, shadowOpacity:Float, shadowRadius:CGFloat, shadowOffset:CGSize) {
        layer.masksToBounds = true
        layer.shadowColor = shadowColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        clipsToBounds = false
        layer.shadowPath = shadowPath
    }
    
    func bringAllSubViewsToFront() {
        for subview in subviews {
            bringSubview(toFront: subview)
        }
    }
    
    func enableUserInteraction() {
        alpha = 1.0
        isUserInteractionEnabled = true
    }
    
    func disableUserInteraction() {
        alpha = 0.3
        isUserInteractionEnabled = false
    }
    
    func makeRounded() {
        clipsToBounds = true
        layer.cornerRadius = frame.height/2
    }
}
