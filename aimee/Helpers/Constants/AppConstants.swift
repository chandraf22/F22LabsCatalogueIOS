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
    case kParallaxVerticalList
    case kParallaxHorizontalList
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
        case .kParallaxVerticalList:
            return AMListsType1Controller()
        case .kParallaxHorizontalList:
            return AMListsType2Controller()
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
        case .kParallaxVerticalList:
            return "Parallax List Vertical"
        case .kParallaxHorizontalList:
            return "Parallax List Horizontal"
        default:
            return "Type1"
        }
    }
    
    func shouldHideNavBar()->Bool {
        switch self {
        case .kParallaxVerticalList:
            return false
        default:
            return true
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
let PARALAX_CELL_HEIGHT:CGFloat = 260.0
let PARALAX_IMAGE_EXTRA_HEIGHT:CGFloat = 40.0
let PARALAX_IMAGE_EXTRA_WIDTH:CGFloat = 50.0
let PARALAX_OFFSET_SPEED:CGFloat = 50.0
