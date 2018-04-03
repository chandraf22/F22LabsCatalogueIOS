//
//  Utilities.swift
//  Catalogue
//
//  Created by Chandrachudh on 18/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    class func subtitleFontType1(size:CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-Regular", size: size)!
    }
    
    class func subtitleFontType2(size:CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-Bold", size: size)!
    }
    
    class func appThemeFont(size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Regular", size: size)!
    }
    
    class func appThemeFontLight(size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Light", size: size)!
    }
}
