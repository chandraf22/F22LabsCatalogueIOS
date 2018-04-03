//
//  AMAnimator.swift
//  Catalogue
//
//  Created by Chandrachudh on 25/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import Foundation
import UIKit


enum AnimationSettings {
    case defaultValue
    case custom(animationDuration:Double, animationDelay:Double, animationOptions:UIViewAnimationOptions)
    
    func getAnimationDuration()->Double {
        switch self {
        case .custom(let animationDuration, _, _):
            return animationDuration
        default:
            return Double(0.5)
        }
    }
    
    func getAnimationDelay()->Double {
        switch self {
        case .custom(_, let animationDelay, _):
            return animationDelay
        default:
            return Double(0.0)
        }
    }
    
    func getAnimationOptions()->UIViewAnimationOptions {
        switch self {
        case .custom(_, _, let animationOptions):
            return animationOptions
        default:
            return UIViewAnimationOptions.curveLinear
        }
    }
}

struct ConstraintAnimationSettings {
    var viewToAnimate:UIView?
    var constraintToAnimate:NSLayoutConstraint?
    var constraintInitialValue:CGFloat?
    var constraintFinalValue:CGFloat?
    var alphaAnimationSettings:AlphaAnimationSettings?
    var springAnimationSettings:SpringAnimationSettings?
    var animationSettings:AnimationSettings = .defaultValue
}

struct AlphaAnimationSettings {
    var alphaFromValue:CGFloat = 0.0
    var alphaToValue:CGFloat = 1.0
}

struct SpringAnimationSettings {
    var damping:CGFloat = 0.75
    var initialSpringVelocity:CGFloat = 0.75
}

class AMAnimator {
    class func animateAllConstraints(allanimationConstraints:[ConstraintAnimationSettings]) {
        for animationConstraint in allanimationConstraints {
            AMAnimator.animateConstraint(constraintAnimationSettings: animationConstraint)
        }
    }
    
    class func animateConstraint(constraintAnimationSettings:ConstraintAnimationSettings) {
        DispatchQueue.main.async {
            
            guard let constraintInitialValue = constraintAnimationSettings.constraintInitialValue else {
                return
            }
            
            guard let constraintFinalValue = constraintAnimationSettings.constraintFinalValue else {
                return
            }
            
            guard let viewToAnimate = constraintAnimationSettings.viewToAnimate else {
                return
            }
            
            constraintAnimationSettings.constraintToAnimate?.constant = constraintInitialValue
            viewToAnimate.superview?.layoutIfNeeded()
            
            if let alphaAnimationSettings = constraintAnimationSettings.alphaAnimationSettings {
                viewToAnimate.alpha = alphaAnimationSettings.alphaFromValue
            }
            
            let animationDuration = constraintAnimationSettings.animationSettings.getAnimationDuration()
            let animationDelay = constraintAnimationSettings.animationSettings.getAnimationDelay()
            let animationOptions = constraintAnimationSettings.animationSettings.getAnimationOptions()
            
            
            if let springAnimationSettings =  constraintAnimationSettings.springAnimationSettings {
                UIView.animate(withDuration: animationDuration, delay: animationDelay, usingSpringWithDamping: springAnimationSettings.damping, initialSpringVelocity: springAnimationSettings.initialSpringVelocity, options: animationOptions, animations: {
                    constraintAnimationSettings.constraintToAnimate?.constant = constraintFinalValue
                    viewToAnimate.superview?.layoutIfNeeded()
                    
                    if let alphaAnimationSettings = constraintAnimationSettings.alphaAnimationSettings {
                        viewToAnimate.alpha = alphaAnimationSettings.alphaToValue
                    }
                }, completion: { (finished) in
                })
            }
            else {
                UIView.animate(withDuration: animationDuration, delay: animationDelay, options: animationOptions, animations: {
                    constraintAnimationSettings.constraintToAnimate?.constant = constraintFinalValue
                    viewToAnimate.superview?.layoutIfNeeded()
                    
                    if let alphaAnimationSettings = constraintAnimationSettings.alphaAnimationSettings {
                        viewToAnimate.alpha = alphaAnimationSettings.alphaToValue
                    }
                }) { (finished) in
                }
            }
        }
    }
}
