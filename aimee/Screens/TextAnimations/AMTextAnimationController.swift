//
//  AMTextAnimationController.swift
//  Catalogue
//
//  Created by Chandrachudh on 23/02/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit
import ZCAnimatedLabel

class AMTextAnimationController: UIViewController {

    @IBOutlet weak var animatingLabel: ZCAnimatedLabel!
    
    let alertActionController = UIAlertController(title: "Pick one animation style!", message: nil, preferredStyle: .actionSheet)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        animatingLabel.text = APP_THEME_TEXT
        animatingLabel.startAppearAnimation()
        
        let names = ["Throw", "Shape Shift", "Default", "Duang", "Fall", "Alpha", "Flying", "Blur", "Reveal", "Spin", "Dash"]
        let animationClasses = [ZCThrownLabel.self, ZCShapeshiftLabel.self, ZCAnimatedLabel.self, ZCDuangLabel.self, ZCFallLabel.self, ZCTransparencyLabel.self, ZCFlyinLabel.self, ZCFocusLabel.self, ZCRevealLabel.self, ZCSpinLabel.self, ZCDashLabel.self];
        
        
        for i in 0..<names.count {
            let name = names[i]
            let classObject = animationClasses[i]
            
            let alertAction = UIAlertAction(title: name, style: .default) { (action) in
                self.animatingLabel.stopAnimation()
                object_setClass(self.animatingLabel, classObject)
                self.animatingLabel.startAppearAnimation()
            }
            
            alertActionController.addAction(alertAction)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil);
        alertActionController.addAction(cancelAction)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapChangeButton(_ sender: Any) {
        self.present(alertActionController, animated: true, completion: nil);
    }
}
