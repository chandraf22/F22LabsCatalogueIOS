//
//  UIViewControllerExtension.swift
//  aimee
//
//  Created by Chandrachudh on 18/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import Foundation
import UIKit

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
}
