//
//  PTRNCustomPageControlType2.swift
//  Patterns
//
//  Created by Chandrachudh on 18/08/17.
//  Copyright © 2017 F22Labs. All rights reserved.
//

import UIKit

class PTRNCustomPageControlType2: UIView {
    
    private var viewsManager = [UIView]()
    var animationDuration:Double = 0.25

    private var _numberOfPages:Int = 3
    var numberOfPages:Int {
        get {
            return _numberOfPages
        }
        set {
            _numberOfPages = newValue
            setupViews()
        }
    }
    
    private var _currentPage:Int = 0
    var currentPage:Int {
        get {
            return _currentPage
        }
    }
    
    private let specialYellow:UIColor = UIColor.rgb(fromHex: 0xFBF500)
    
    override init(frame:CGRect) {
        super.init(frame:frame)
    }
    
    convenience init() {
        self.init(frame:.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        for view in viewsManager {
            view.removeFromSuperview()
        }
        viewsManager.removeAll()
        
        
        for _ in 0..<numberOfPages {
            let view = UIView.init()
            view.backgroundColor = .white
            addSubview(view)
            viewsManager.append(view)
        }
        
        setupFrames()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func setupFrames() {
        
        var x:CGFloat = 20.0
        let y:CGFloat = 5.0
        let normalSize:CGFloat = 11.0
        let selectedSize:CGFloat = 17.0
        
        for i in 0..<numberOfPages {
            
            let view = viewsManager[i]
            
            if currentPage == i {
                view.backgroundColor = specialYellow
                view.changeFrameAnimated(rect: CGRect(x: x, y: y, width: selectedSize, height: selectedSize), cornerRadius: selectedSize/2, animationDuration: animationDuration)
                
                x += selectedSize
            }
            else {
                view.backgroundColor = .white
                view.changeFrameAnimated(rect: CGRect(x: x, y: y+((selectedSize-normalSize)/2), width: normalSize, height: normalSize), cornerRadius: normalSize/2, animationDuration: animationDuration)
                
                x += normalSize
            }
            
            x += 5
        }
        
    }
    
    func setSelected(index:Int) {
        _currentPage = index
        setupFrames()
    }
}

extension UIView {
    func changeFrameAnimated(rect:CGRect, cornerRadius:CGFloat, animationDuration:Double) {
        
        UIView.animate(withDuration: animationDuration, delay: 0.0, options: .curveEaseOut, animations: {
            self.frame = rect
            self.layer.cornerRadius = cornerRadius
        }, completion: nil)
    }
}
