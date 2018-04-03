//
//  NSAttributtedStringExtension.swift
//  Catalogue
//
//  Created by Chandrachudh on 18/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    func addParagraphLineSpacing(space:CGFloat, alignment:NSTextAlignment) {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = space
        paragraphStyle.alignment = alignment
        
        let rangeText = string
        
        addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange.init(location: 0, length: rangeText.count))
    }
}

extension String {
    public func isEmail() ->Bool {
        let regExPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regExPattern)
        if (!self.containsEmoji && predicate.evaluate(with: self)) {
            return true;
        }
        return false;
    }
    
    private var containsEmoji: Bool {
        for scalar in unicodeScalars {
            switch scalar.value {
            case 0x1F600...0x1F64F, // Emoticons
            0x1F300...0x1F5FF, // Misc Symbols and Pictographs
            0x1F680...0x1F6FF, // Transport and Map
            0x2600...0x26FF,   // Misc symbols
            0x2700...0x27BF,   // Dingbats
            0xFE00...0xFE0F:   // Variation Selectors
                return true
            default:
                continue
            }
        }
        return false
    }
}
