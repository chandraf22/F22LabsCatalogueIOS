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
}
