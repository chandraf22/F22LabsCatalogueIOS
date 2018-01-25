//
//  AppConstants.swift
//  aimee
//
//  Created by Chandrachudh on 18/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import Foundation
import UIKit

enum DeviceType {
    case iPhone5
    case iPhone6
    case iPhone6Plus
    case iPhoneX
}

enum Gender {
    case female
    case male
    case notSpecified
}

enum HudPosition {
    case top,bottom
}

enum HudBgColor {
    case red,blue,gray
}

enum ScreenType {
    case kAuthType1
    case kAuthType2
    case kInterestType1
    case kAccomplishmentsType1
    case kUserDetailsEntryType1
    case none
    
    func getViewController() -> UIViewController {
        switch self {
        case .kAuthType1:
            return AMAuthViewController()
        case .kAuthType2:
            return PTRNLoginType3ViewController()
        case .kInterestType1:
            return AMInterestsViewController()
        case .kAccomplishmentsType1:
            return AMAccomplishmentsController()
        case .kUserDetailsEntryType1:
            return AMUserDetailsEntryController()
        default:
            return AMAuthViewController()
        }
    }
    
    func getTitle()->String {
        switch self {
        case .kAuthType1:
            return "Type1"
        case .kAuthType2:
            return "Type2"
        case .kInterestType1:
            return "Type1"
        case .kAccomplishmentsType1:
            return "Type1"
        case .kUserDetailsEntryType1:
            return "Type1"
        default:
            return "Type1"
        }
    }
}

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

let APP_NAME = "aimee"

let APP_THEME_DATEFORMAT = "EE, dd MMMM, yyyy"

var currentDeviceType:DeviceType = {
    var deviceType = DeviceType.iPhone6Plus
    
    if SCREEN_HEIGHT < 600 {
        deviceType = .iPhone5
    }
    else if SCREEN_HEIGHT < 670 {
        deviceType = .iPhone6
    }
    else if SCREEN_HEIGHT > 800 {
        deviceType = .iPhoneX
    }
    
    return deviceType
}()

let animationMultiplier = 1.0
