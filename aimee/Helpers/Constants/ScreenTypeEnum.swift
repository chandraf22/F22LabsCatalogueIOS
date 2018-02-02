//
//  ScreenTypeEnum.swift
//  aimee
//
//  Created by Chandrachudh on 30/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import Foundation
import UIKit


let screenTypesDataSource = [["type" : "AUTHENTICATION PAGES","items":[ScreenType.kAuthType1,ScreenType.kAuthType2]],
                  ["type" : "USER DATA ENTRY PAGES","items":[ScreenType.kUserDetailsEntryType1]],
                  ["type" : "INTEREST SELECTION PAGES","items":[ScreenType.kInterestType1]],
                  ["type" : "ACCOMPLISHMENTS PAGES","items":[ScreenType.kAccomplishmentsType1]],
                  ["type" : "PARALLAX LIST PAGES","items":[ScreenType.kParallaxVerticalList, .kParallaxHorizontalList]],
                  ["type" : "MEMBERS LIST PAGES","items":[ScreenType.kMembersListType1, .kMembersListType2]],
                  ["type" : "EVERYTHING ELSE","items":[ScreenType.kAppDrawer]]]


enum ScreenType {
    case kAuthType1
    case kAuthType2
    case kInterestType1
    case kAccomplishmentsType1
    case kUserDetailsEntryType1
    case kParallaxVerticalList
    case kParallaxHorizontalList
    case kMembersListType1
    case kMembersListType2
    case kAppDrawer
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
        case .kMembersListType1:
            return AMMemListType1VerController()
        case .kMembersListType2:
            return AMMemListType2HorController()
        case .kAppDrawer:
            return AMAppDrawerController()
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
        case .kMembersListType1:
            return "Members List Vertical"
        case .kMembersListType2:
            return "Members List Horizontal"
        case .kAppDrawer:
            return "App Drawer"
        default:
            return "Type1"
        }
    }
    
    func shouldHideNavBar()->Bool {
        switch self {
        case .kParallaxVerticalList:
            return false
        case .kAppDrawer:
            return false
        default:
            return true
        }
    }
}
