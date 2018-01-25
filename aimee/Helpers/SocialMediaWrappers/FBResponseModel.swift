//
//  FBResponseModel.swift
//  SocialIntegration
//
//  Created by Chandrachudh on 25/01/2018.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit

class FBResponseModel:NSObject {
    var name:String?
    var firstName:String?
    var lastName:String?
    var d_picture:String?
    var user_id:String?
    var access_token:String?
    var email:String?
    var birthday:String?
    var gender:Gender = .notSpecified
    
    var inputDictionary:Dictionary<String,Any>?
    
    convenience init(input dictionary:Dictionary<String,Any>) {
        self.init()
        inputDictionary = dictionary
        name = dictionary["name"] as! String?
        email = dictionary["email"] as! String?
        if let userId = dictionary["id"] {
            d_picture = "https://graph.facebook.com/"+"\(userId)/"+"picture?width=\(Int(SCREEN_WIDTH))&height=\(Int(SCREEN_HEIGHT))"
        }
        user_id = dictionary["id"] as! String?
        access_token = dictionary["accessToken"] as! String?
        firstName = dictionary["first_name"] as! String?
        lastName = dictionary["last_name"] as! String?
        
        if let genderStrFB = dictionary["gender"] {
            let userGenderStr = genderStrFB as! String
            
            if userGenderStr == "male" {
                gender = .male
            }
            else {
                gender = .female
            }
        }
        
        if let birthDayStrFB = dictionary["birthday"] {
            let brithDayFB = birthDayStrFB as! String
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            
            if let birthDayDate = dateFormatter.date(from: brithDayFB) {
                dateFormatter.dateFormat = APP_THEME_DATEFORMAT
                birthday = dateFormatter.string(from: birthDayDate)
            }
        }
    }
    
    
    func getPicUrlStringWithFrame(width:Int, height:Int)->String {
        
        if let userId = user_id {
            return "https://graph.facebook.com/"+"\(userId)/"+"picture?width=\(width)&height=\(height)"
        }
        return d_picture!
    }
}

