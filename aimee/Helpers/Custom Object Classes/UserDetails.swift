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
