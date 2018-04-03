//
//  AppConstants.swift
//  Catalogue
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

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

let APP_NAME = "Catalogue"

let APP_THEME_DATEFORMAT = "EE, dd MMMM, yyyy"

let YES = true
let NO = false

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

let APP_DRAWER_EXITED_STATE_DURATION:Double = 5.0

let APP_THEME_TEXT = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vitae dapibus purus. Pellentesque bibendum urna sed porttitor euismod. Pellentesque finibus libero libero, id porta ipsum convallis sed. Sed fringilla metus porta, congue quam faucibus, ornare ante. Phasellus et ipsum et lacus iaculis lacinia sed et erat. Phasellus facilisis risus et vulputate auctor. Pellentesque imperdiet vel arcu sit amet euismod. Suspendisse at mauris nec nibh molestie auctor. Pellentesque ornare aliquet felis. Phasellus in porttitor mauris. Ut quis nulla at ligula efficitur efficitur. Fusce eget gravida justo. Sed aliquet et nunc non malesuada. Nullam eget tincidunt enim, ut finibus orci. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae;\nEtiam quam enim, ultricies a pretium ut, congue eget arcu. Duis vel tincidunt est, vel viverra nulla. Praesent facilisis hendrerit lorem, non volutpat augue. Proin ultricies turpis vitae neque vehicula, a molestie ante mollis. Duis ultricies lorem at orci luctus, ac venenatis nunc pharetra. Mauris vel diam id massa condimentum condimentum ac vitae mauris. Phasellus et augue ligula. Suspendisse ac pellentesque mi. Ut luctus ex ac felis dignissim consectetur. Fusce vel ornare magna. Proin aliquet justo non sagittis hendrerit. Integer tincidunt ultricies gravida. Nulla tincidunt nulla dolor, at faucibus felis fringilla vitae.\nMaecenas vitae mollis turpis. In bibendum metus ut orci pulvinar hendrerit. Nam nunc elit, placerat vitae volutpat eget, luctus bibendum odio. Etiam interdum diam sed condimentum lacinia. Donec molestie nibh eget mi condimentum eleifend. Cras a tellus at ante malesuada mattis sit amet ac ipsum. Maecenas congue ullamcorper mi vitae hendrerit. Vestibulum eu mi non ex venenatis rhoncus. Vivamus consequat dolor id nisl maximus sodales. Donec in eleifend risus, id varius tortor. Integer viverra mauris nec massa mollis accumsan. Integer auctor tellus non dui hendrerit tempor et sed est.\nSuspendisse viverra mollis risus vitae imperdiet. Phasellus ut magna ligula. Donec vehicula, ante at dapibus ullamcorper, enim ipsum facilisis mauris, ut efficitur diam mauris id metus. Etiam fringilla erat risus, at posuere neque facilisis ac. Phasellus bibendum malesuada dolor vitae ullamcorper. Nulla congue sapien tempus, elementum eros at, sagittis ipsum. Praesent non venenatis elit. Aliquam gravida nunc id turpis efficitur pretium. Morbi sed porttitor eros. Nam justo ligula, varius in nulla vitae, accumsan rhoncus lacus. Mauris ultrices aliquet quam, eu molestie lacus porttitor a.\nSed lobortis posuere laoreet. Quisque vel commodo ipsum. Quisque luctus ante suscipit, molestie velit facilisis, elementum enim. Aenean a felis in neque volutpat maximus id quis justo. Nullam pellentesque sed nisi in iaculis. In porta lobortis viverra. Vestibulum tellus odio, aliquam volutpat cursus non, blandit id arcu. Vivamus sed sapien scelerisque, ultricies felis ut, vulputate orci. Phasellus eget mauris enim. Nulla ut ullamcorper nibh, id commodo risus. Duis id sem sagittis sapien mattis accumsan a in eros. Morbi scelerisque nunc velit, sed euismod justo iaculis eu. Nullam ipsum ex, sodales et est a, gravida euismod eros. Donec non nunc sed purus tristique pretium vel at elit."
