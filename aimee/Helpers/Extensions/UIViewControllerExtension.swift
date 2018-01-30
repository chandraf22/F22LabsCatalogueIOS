//
//  UIViewControllerExtension.swift
//  aimee
//
//  Created by Chandrachudh on 18/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import Foundation
import UIKit
import SwiftMessages

extension UIViewController {
    func showAlert(message:String, cancelTitle:String) {
        let alertController = UIAlertController.init(title: APP_NAME, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: cancelTitle, style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func addDismissGesture() {
        let keyBoardDismissGesture = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyBoard))
        view.addGestureRecognizer(keyBoardDismissGesture)
        view.bringAllSubViewsToFront()
    }
    
    @objc func dismissKeyBoard() {
        view.endEditing(true)
    }
    
    func showErrorHud(position: HudPosition, message:String, bgColor: HudBgColor, isPermanent:Bool) {
        DispatchQueue.main.async {
            
            let messageView:MessageView? = MessageView.viewFromNib(layout: .messageView)
            
            messageView?.configureContent(title: message, body: "", iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: nil, buttonTapHandler: nil)
            
            switch bgColor {
            case .red:
                messageView?.configureTheme(backgroundColor:AMErrorRed, foregroundColor: UIColor.white, iconImage: nil, iconText: "")
                break
            case.gray:
                messageView?.configureTheme(backgroundColor:AMLightGray, foregroundColor: UIColor.white, iconImage: nil, iconText: "")
                break
            default:
                messageView?.configureTheme(backgroundColor: AMDenimBlue, foregroundColor: UIColor.white, iconImage: nil, iconText: "")
                break
            }
            
            messageView?.bodyLabel?.isHidden = true
            messageView?.titleLabel?.textAlignment = .center
            messageView?.titleLabel?.font = Utilities.appThemeFont(size: 16)
            messageView?.titleLabel?.adjustsFontSizeToFitWidth = true
            messageView?.titleLabel?.adjustsFontForContentSizeCategory = true
            messageView?.button?.isHidden = true
            messageView?.iconImageView?.isHidden = true
            messageView?.iconLabel?.isHidden = true
            
            var config = SwiftMessages.defaultConfig
            config.duration = .seconds(seconds: 2)
            if isPermanent == true {
                config.duration = .forever
            }
            config.dimMode = .none
            config.interactiveHide = true
            config.preferredStatusBarStyle = .lightContent
            
            if position == .bottom {
                config.presentationStyle = .bottom
            }
            else {
                config.presentationStyle = .top
            }
            
            SwiftMessages.show(config: config, view: (messageView)!)
        }
    }
    
    func getUserListDataSource() -> [ListUserData] {
        let allUserImages = [#imageLiteral(resourceName: "User1"), #imageLiteral(resourceName: "User2"),#imageLiteral(resourceName: "User3"),#imageLiteral(resourceName: "User4"),#imageLiteral(resourceName: "User5"),#imageLiteral(resourceName: "User6"),#imageLiteral(resourceName: "User7"),#imageLiteral(resourceName: "User8"),#imageLiteral(resourceName: "User9"),#imageLiteral(resourceName: "User10"),#imageLiteral(resourceName: "User11"),#imageLiteral(resourceName: "User12"),#imageLiteral(resourceName: "User13"),#imageLiteral(resourceName: "User14"),#imageLiteral(resourceName: "User15"),#imageLiteral(resourceName: "User16"),#imageLiteral(resourceName: "User17"),#imageLiteral(resourceName: "User18"),#imageLiteral(resourceName: "User19"),#imageLiteral(resourceName: "User20")]
        let allUserFirstNames = ["Sasha","Pauline","Laurie","Christy","Debbie","Constance","Ella","Stacey","Becky","Roberta",
                                 "Freddie","Tommy","Gregory","Jeremy","Patrick","Elmer","Victor","Gary","Aiden","Lewis"]
        let allUserLastNames = ["O'Connell","George","Duncan","Mcdonalid","Barrett","Owens","Collins","Austin","Stewart","Scott",
                                "Brown","Spencer","Torres","Fisher","Lambert","Daniels","Nichols","Hayes","Nichols","Horton"]
        let allUserConnectionsCount = [100,95,90,85,80,75,70,65,60,55,50,45,40,35,30,25,20,15,10,5]
        
        var dataSource = [ListUserData]()
        
        for i in 0..<allUserImages.count {
            let user = ListUserData()
            user.firstName = allUserFirstNames[i]
            user.lastName = allUserLastNames[i]
            user.avatar = allUserImages[i]
            user.connections = allUserConnectionsCount[i]
            
            dataSource.append(user)
        }
        
        return dataSource.shuffled
    }
}
