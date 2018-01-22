//
//  AMAuthViewController.swift
//  aimee
//
//  Created by Chandrachudh on 18/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

enum AuthMode {
    case signUp
    case signIn
}

class AMAuthViewController: UIViewController {
    
    var currentAuthMode = AuthMode.signUp
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var authInfoBase: UIView!
    @IBOutlet weak var btnOtherOption: UIButton!
    @IBOutlet weak var txtInfo: UITextView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var emailBaseView: UIView!
    @IBOutlet weak var passwordBaseView: UIView!
    @IBOutlet weak var subContentBaseView: UIView!
    @IBOutlet weak var btnAuth: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    @IBOutlet weak var signupSubContentView: UIView!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var imgEmailIcon: UIImageView!
    @IBOutlet weak var imgPasswordIcon: UIImageView!
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var lcContentViewCenterY: NSLayoutConstraint!
    @IBOutlet weak var lcTitleTopSpace: NSLayoutConstraint!
    @IBOutlet weak var lcContentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lcEmailBaseViewTopSpace: NSLayoutConstraint!
    @IBOutlet weak var lcInfoViewTopSpaceToContentView: NSLayoutConstraint!
    @IBOutlet weak var lcSwitchButtonBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var lcTxtInfoTopSpaceToContenyView: NSLayoutConstraint!
    
    
    
    var originalTopSpaceToSafeArea:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareViews()
        
        txtEmail.delegate = self
        txtPassword.delegate = self
        
        switch currentAuthMode {
        case .signIn:
            changeIntoSignInMode(animated: false)
            break
        default:
            changeIntoSignUpMode(animated: false)
            break
        }
        
        addDismissGesture()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didTapOtherOptionButton(_ sender: Any) {
        dismissKeyBoard()
        
        switch currentAuthMode {
        case .signIn:
            currentAuthMode = .signUp
            changeIntoSignUpMode(animated: true)
            break
        default:
            currentAuthMode = .signIn
            changeIntoSignInMode(animated: true)
            break
        }
    }
    
    @IBAction func didTapbackbutton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func didTapForgotPasswordButton(_ sender: Any) {
        dismissKeyBoard()
    }
    
    @IBAction func didTapCheckButton(_ sender: Any) {
        dismissKeyBoard()
        
        btnCheck.isSelected = !btnCheck.isSelected
        
        if btnCheck.isSelected {
            markBtnCheckSelected()
        }
        else {
            markBtnCheckUnSelected()
        }
    }
    
    @IBAction func didTapAuthButton(_ sender: Any) {
        dismissKeyBoard()
        
        if currentAuthMode == .signUp {
            if btnCheck.isSelected == false {
                showAlert(message: "Please enable check box to continue.", cancelTitle: "OK")
                return
            }
            else {
                signUp()
            }
        }
        else {
            login()
        }
    }
    
    
    func login() {
        if verify() == false {
            return
        }
        
        showAlert(message: "Sign in success!", cancelTitle: "OK")
    }
    
    func signUp() {
        if verify() == false {
            return
        }
        
        showAlert(message: "Sign up success!", cancelTitle: "OK")
    }
    
    func verify() -> Bool {
        if (txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines).count)! == 0 {
            showAlert(message: "Email cannot be empty", cancelTitle: "OK")
            return false
        }
        
        if txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmail() == false {
            showAlert(message: "Invalid Email", cancelTitle: "OK")
            return false
        }
        
        if (txtPassword.text?.trimmingCharacters(in: .whitespacesAndNewlines).count)! < 8 {
            showAlert(message: "Password must be atleast 8 characters", cancelTitle: "OK")
            return false
        }
        
        return true
    }
}


extension AMAuthViewController {
    func changeIntoSignUpMode(animated:Bool) {
        var duration = 0.0
        if animated {
            duration = 0.5
        }
        setScreenTitle(title: "Sign up.", animationDuration: duration)
        
        let infoStrPart1 = "By creating an account you agree to our\n"
        let infoStrPart2 = "Terms of Service"
        let infoStrPart3 = " and "
        let infoStrPart4 = "Privacy Policy"
        let finalStr = infoStrPart1 + infoStrPart2 + infoStrPart3 + infoStrPart4
        
        let infoStrPart2Range = (finalStr as NSString).range(of: infoStrPart2)
        let infoStrPart4Range = (finalStr as NSString).range(of: infoStrPart4)
        
        let infoAttrStr = NSMutableAttributedString(string: finalStr)
        infoAttrStr.addAttribute(.font, value: Utilities.subtitleFontType2(size: 12.0), range: infoStrPart2Range)
        infoAttrStr.addAttribute(.font, value: Utilities.subtitleFontType2(size: 12.0), range: infoStrPart4Range)
        infoAttrStr.addAttribute(.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: infoStrPart2Range)
        infoAttrStr.addAttribute(.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: infoStrPart4Range)
        infoAttrStr.addAttribute(.link, value: URL.init(string: "https://www.google.com") as Any, range: infoStrPart2Range)
        infoAttrStr.addAttribute(.link, value: URL.init(string: "https://www.facebook.com") as Any, range: infoStrPart4Range)
        infoAttrStr.addAttribute(.foregroundColor, value: UIColor.black, range: infoStrPart2Range)
        infoAttrStr.addAttribute(.foregroundColor, value: UIColor.black, range: infoStrPart4Range)
        infoAttrStr.addParagraphLineSpacing(space: 7.0, alignment: .center)
        
        authInfoBase.isHidden = false
        txtInfo.isHidden = false
        authInfoBase.animateFade(duration: duration)
        txtInfo.attributedText = infoAttrStr
        
        subContentBaseView.animateFade(duration: duration)
        btnForgotPassword.isHidden = true
        signupSubContentView.isHidden = false
        btnAuth.setTitle("Sign Up", for: .normal)
        markBtnCheckUnSelected()
        
        let switchStrPart1 = "Already have an account? "
        let switchStrPart2 = "Log In"
        setOtherOptionButtonTitle(switchStrPart1: switchStrPart1, switchStrPart2: switchStrPart2)
        animateBottomViews(shouldShow: true, animated: true)
    }
    
    func changeIntoSignInMode(animated:Bool) {
        var duration = 0.0
        
        if animated {
            duration = 0.25
        }
        setScreenTitle(title: "Sign in.", animationDuration: duration)
        
        authInfoBase.animateFade(duration: duration)
        
        subContentBaseView.animateFade(duration: duration)
        btnForgotPassword.isHidden = false
        
        signupSubContentView.isHidden = true
        btnAuth.setTitle("Sign In", for: .normal)
        markBtnCheckUnSelected()
        
        let switchStrPart1 = "Don't have and account? "
        let switchStrPart2 = "Sign Up"
        setOtherOptionButtonTitle(switchStrPart1: switchStrPart1, switchStrPart2: switchStrPart2)
        
        animateBottomViews(shouldShow: false, animated: animated)
    }
    
    func setOtherOptionButtonTitle(switchStrPart1:String, switchStrPart2:String) {
        let switchStrFinal = switchStrPart1 + switchStrPart2
        
        let switchStrPart2Range = (switchStrFinal as NSString).range(of: switchStrPart2)
        let finalRange = NSRange.init(location: 0, length: switchStrFinal.count)
        
        let switchAttrStr = NSMutableAttributedString.init(string: switchStrFinal)
        switchAttrStr.addAttribute(.font, value: Utilities.appThemeFontLight(size: 12), range: finalRange)
        switchAttrStr.addAttribute(.foregroundColor, value: AMWarmGrey, range: finalRange)
        switchAttrStr.addAttribute(.foregroundColor, value: UIColor.black, range: switchStrPart2Range)
        btnOtherOption.setAttributedTitle(switchAttrStr, for: .normal)
    }
    
    func setScreenTitle(title:String, animationDuration:Double) {
        DispatchQueue.main.async {
            let titleAttrStr = NSMutableAttributedString(string: title)
            titleAttrStr.addAttribute(.backgroundColor, value: AMPumpkinOrange, range: NSRange(location: 0, length: 4))
            self.lblTitle.animateFade(duration: animationDuration)
            self.lblTitle.attributedText = titleAttrStr
        }
    }
    
    func prepareViews() {
        
        btnBack.contentHorizontalAlignment = .left
        
        if currentDeviceType == .iPhone5 {
            lcTitleTopSpace.constant = 20.0
            lcContentViewHeight.constant = 250.0
            lcEmailBaseViewTopSpace.constant = 10
        }
        view.layoutIfNeeded()
        
        
        let cornerRadius:CGFloat = 6.0
        
        let shapeLayer = CAShapeLayer()
        let shapePath = UIBezierPath.init(roundedRect: CGRect(x:0, y:0, width:SCREEN_WIDTH-32, height:lcContentViewHeight.constant), byRoundingCorners: [.bottomRight, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        shapeLayer.path = shapePath.cgPath
        shapeLayer.fillColor = UIColor.white.cgColor
        contentView.layer.addSublayer(shapeLayer)
        contentView.addShadowWith(shadowPath: shapePath.cgPath, shadowColor: UIColor.black.cgColor, shadowOpacity: 0.1, shadowRadius: 30.0, shadowOffset: CGSize(width: 5, height: -5))
        
        contentView.bringAllSubViewsToFront()
        
        btnAuth.layer.cornerRadius = 4.0
        btnCheck.layer.cornerRadius = 4.0
        btnCheck.imageView?.tintColor = UIColor.white
        
        let emailPlaceHolderAttr = NSMutableAttributedString.init(string: "EMAIL")
        let emailPlaceHolderRange = NSRange.init(location: 0, length: emailPlaceHolderAttr.string.count)
        emailPlaceHolderAttr.addAttribute(.foregroundColor, value: AMWarmGrey2, range: emailPlaceHolderRange)
        emailPlaceHolderAttr.addAttribute(.font, value: Utilities.appThemeFont(size: 12), range: emailPlaceHolderRange)
        txtEmail.attributedPlaceholder = emailPlaceHolderAttr
        
        imgEmailIcon.image = #imageLiteral(resourceName: "email").withRenderingMode(.alwaysTemplate)
        imgEmailIcon.tintColor = UIColor.rgb(fromHex: 0xd6d6d6)
        
        let passwordPlaceHolderAttr = NSMutableAttributedString.init(string: "PASSWORD")
        let passwordPlaceHolderRange = NSRange.init(location: 0, length: passwordPlaceHolderAttr.string.count)
        passwordPlaceHolderAttr.addAttribute(.foregroundColor, value: AMWarmGrey2, range: passwordPlaceHolderRange)
        passwordPlaceHolderAttr.addAttribute(.font, value: Utilities.appThemeFont(size: 12), range: passwordPlaceHolderRange)
        txtPassword.attributedPlaceholder = passwordPlaceHolderAttr
        
        imgPasswordIcon.image = #imageLiteral(resourceName: "password").withRenderingMode(.alwaysTemplate)
        imgPasswordIcon.tintColor = UIColor.rgb(fromHex: 0xd6d6d6)
    }
    
    func animateBottomViews(shouldShow:Bool, animated:Bool) {
        
        var duration:Double = 0.5
        
        if animated == false {
            duration = 0.0
        }
        
        var animationOption:UIViewAnimationOptions = .curveEaseOut
        
        var InfoViewTopSpaceToContentView:CGFloat = -20.0
        var TxtInfoTopSpaceToContenyView:CGFloat = 32.0
        var SwitchButtonBottomSpace:CGFloat = 1.0
        
        lcInfoViewTopSpaceToContentView.constant = (SCREEN_HEIGHT/2) + 50
        lcSwitchButtonBottomSpace.constant = -1 * ((SCREEN_HEIGHT) + 50)
        lcTxtInfoTopSpaceToContenyView.constant = 32.0 + (SCREEN_HEIGHT/2) + 50
        self.view.layoutIfNeeded()
        
        
        if shouldShow == false {
            duration = 0.25
            animationOption = .curveEaseIn
            lcInfoViewTopSpaceToContentView.constant = -20
            lcSwitchButtonBottomSpace.constant = 1.0
            lcTxtInfoTopSpaceToContenyView.constant = 32.0
            self.view.layoutIfNeeded()
            
            InfoViewTopSpaceToContentView = (SCREEN_HEIGHT/2) + 50
            SwitchButtonBottomSpace = -1 * ((SCREEN_HEIGHT) + 50)
            TxtInfoTopSpaceToContenyView = 32.0 + (SCREEN_HEIGHT/2) + 50
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: duration, delay: 0.0, options: animationOption, animations: {
                    self.lcSwitchButtonBottomSpace.constant = SwitchButtonBottomSpace
                    self.view.layoutIfNeeded()
                }) { (finished) in
                }
            }
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: duration, delay: duration/2, options: animationOption, animations: {
                    self.lcTxtInfoTopSpaceToContenyView.constant = TxtInfoTopSpaceToContenyView
                    self.view.layoutIfNeeded()
                }) { (finished) in
                }
            }
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: duration, delay: duration * 3/4, options: animationOption, animations: {
                    self.lcInfoViewTopSpaceToContentView.constant = InfoViewTopSpaceToContentView
                    self.view.layoutIfNeeded()
                }) { (finished) in
                    self.authInfoBase.isHidden = true
                    self.txtInfo.isHidden = true
                    
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: duration/2, delay: 0.0, options: animationOption, animations: {
                            self.lcSwitchButtonBottomSpace.constant = 1.0
                            self.view.layoutIfNeeded()
                        }) { (finished) in
                        }
                    }
                }
            }
            return
        }
        else {
            let springDamping:CGFloat = 0.7
            let initialVelocity:CGFloat = 0.5
            DispatchQueue.main.async {
               UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: springDamping, initialSpringVelocity: initialVelocity, options: animationOption, animations: {
                    self.lcInfoViewTopSpaceToContentView.constant = InfoViewTopSpaceToContentView
                    self.view.layoutIfNeeded()
                }) { (finished) in
                    
                }
            }
            DispatchQueue.main.async {
                UIView.animate(withDuration: duration, delay: duration/2, usingSpringWithDamping: springDamping, initialSpringVelocity: initialVelocity, options: animationOption, animations: {
                    self.lcTxtInfoTopSpaceToContenyView.constant = TxtInfoTopSpaceToContenyView
                    self.view.layoutIfNeeded()
                }, completion: { (finished) in
                    
                })
            }
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: duration, delay: duration*3/4, usingSpringWithDamping: springDamping, initialSpringVelocity: initialVelocity, options: animationOption, animations: {
                    self.lcSwitchButtonBottomSpace.constant = SwitchButtonBottomSpace
                    self.view.layoutIfNeeded()
                }) { (finished) in
                }
            }
        }
    }
    
    func markBtnCheckSelected() {
        btnCheck.isSelected = true
        btnCheck.backgroundColor = AMBrightBlue
        btnCheck.layer.borderWidth = 0.0
    }
    
    func markBtnCheckUnSelected() {
        btnCheck.isSelected = false
        btnCheck.backgroundColor = UIColor.white
        btnCheck.layer.borderColor = AMWarmGrey2.cgColor
        btnCheck.layer.borderWidth = 1.0
    }
    
    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        let endFrame = ((notification as NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        if endFrame.origin.y != SCREEN_HEIGHT {//Keyboard present for textview
            if lcContentViewCenterY.constant == 0 {
                let maxY = contentView.frame.maxY
                
                if maxY > endFrame.origin.y {
                    let diff = maxY - endFrame.origin.y
                    lcContentViewCenterY.constant = -1 * diff
                }
            }
        }
        else {//Keyboard dismissed for textview
            lcContentViewCenterY.constant = 0
        }
        view.layoutIfNeeded()
    }
}

extension AMAuthViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            txtPassword.becomeFirstResponder()
        }
        else {
            if currentAuthMode == .signUp {
                if btnCheck.isSelected == false {
                    dismissKeyBoard()
                }
                else {
                    signUp()
                }
            }
            else {
                login()
            }
        }
        return true
    }
}



























