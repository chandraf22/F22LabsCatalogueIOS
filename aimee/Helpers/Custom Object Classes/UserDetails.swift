//
//  UserDetails.swift
//  aimee
//
//  Created by Chandrachudh on 25/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

class UserDetails: NSObject {
    var firstName = ""
    var lastName = ""
    var dateOfBirth = ""
    var gender = Gender.female
    var avatar = UIImage()
    var avatarURL = ""
    var email = ""
    var facebookModel:FBResponseModel?
    
}

class ListUserData: UserDetails {
    var connections:Int = 0
    var isSelected = false
}

class UserProfileData: ListUserData {
    var entries:Int = 0
    var interests = [String]()
    var location = ""
    
    class func getDummyUserProfileInfo() -> UserProfileData {
        let userData = UserProfileData()
        
        let allUserprofiles = [#imageLiteral(resourceName: "UserProfile1"),#imageLiteral(resourceName: "UserProfile2"), #imageLiteral(resourceName: "UserProfile3"), #imageLiteral(resourceName: "UserProfile4")]
        let genders = [Gender.female, Gender.male, Gender.male,Gender.female]
        let firstnames = ["Jane", "Jhon", "Jhon", "Jane"]
        
        let randomIndex = Int(arc4random()) % allUserprofiles.count
        userData.avatar = allUserprofiles[randomIndex]
        userData.firstName = firstnames[randomIndex]
        userData.lastName = "Doe"
        userData.gender = genders[randomIndex]
        userData.entries = 32
        userData.interests = ["ANIMATION", "ARCHITECTURE", "ART", "CRAFTS", "DANCING", "DESIGN", "DRAWING", "HOME IMPROVEMENT", "INFOGRAPHICS", "INTERIOR DESIGN", "PAINTING", "BLUE CROSS","ACTION AND ADVENTURE","COOKBOOKS","CERAMICS CRAFTS","SCIENCE","GARDENING","SAFARI","JOURNALS", "BIOGRAPHIES"].sorted()
        userData.location = "Boston, United States"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = APP_THEME_DATEFORMAT
        userData.dateOfBirth = dateFormatter.string(from: Date().addingTimeInterval((60*60*24*365*21) * (-1)))
        
        return userData
    }
}
