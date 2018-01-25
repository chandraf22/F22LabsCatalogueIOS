//
//  UIImageView+Extension.swift
//  aimee
//
//  Created by Chandrachudh on 25/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit
import SDWebImage

enum ImageStyle:Int {
    case squared
    case rounded
}

extension UIImageView {
    
    func am_setImage(urlString:String,imageStyle:ImageStyle) {
        am_setImage(urlString: urlString, imageStyle: imageStyle, placeholderImage: nil)
    }
    
    func am_setImage(urlString:String, imageStyle:ImageStyle, placeholderImage:UIImage?) {
        
        self.image = nil
        if urlString.count < 1 {
            image = placeholderImage
            return
        }
        
        setShowActivityIndicator(true)
        setIndicatorStyle(.gray)
        clipsToBounds = false
        layer.shouldRasterize = true
        if SDWebImageManager.shared().cachedImageExists(for: NSURL.init(string: urlString) as URL!) {
            self.backgroundColor = .clear
            if(imageStyle == .rounded) {
                self.layer.cornerRadius = self.frame.height/2
            }
            else if(imageStyle == .squared){
                self.layer.cornerRadius = 0.0
            }
            self.sd_setImage(with: NSURL.init(string: urlString) as URL!)
            self.clipsToBounds = true
            self.layer.shouldRasterize = false
            self.animateFade(duration: 0.5)
        }
        else {
            self.sd_setImage(with: NSURL.init(string: urlString) as URL!, placeholderImage:placeholderImage, options: [.avoidAutoSetImage,.highPriority,.retryFailed,.delayPlaceholder], completed: { (image, error, cacheType, url) in
                if error == nil {
                    DispatchQueue.main.async {
                        self.backgroundColor = .clear
                        if(imageStyle == .rounded) {
                            self.layer.cornerRadius = self.frame.height/2
                        }
                        else if(imageStyle == .squared){
                            self.layer.cornerRadius = 0.0
                        }
                        self.clipsToBounds = true
                        self.layer.shouldRasterize = false
                        self.image = image
                        self.animateFade(duration: 0.5)
                    }
                }
                else {
                    self.layer.shouldRasterize = false
                }
            })
        }
    }
}
