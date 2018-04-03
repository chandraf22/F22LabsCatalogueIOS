//
//  UITextFieldExtension.swift
//  Catalogue
//
//  Created by Chandrachudh on 18/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func becomeFirstResponderOnLoad() {
        self.perform(#selector(becomeFirstResponder), with: nil, afterDelay: 0.75)
    }
}
