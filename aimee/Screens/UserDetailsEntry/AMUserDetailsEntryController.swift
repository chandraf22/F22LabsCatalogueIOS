//
//  AMUserDetailsEntryController.swift
//  aimee
//
//  Created by Chandrachudh on 23/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit
import Fusuma
import FBSDKLoginKit

class AMUserDetailsEntryController: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnFBAcess: UIButton!
    @IBOutlet weak var lblMale: UILabel!
    @IBOutlet weak var lblFemale: UILabel!
    @IBOutlet weak var btnContinue: UIButton!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtDateOfBirth: UITextField!
    @IBOutlet weak var imgCalendar: UIImageView!
    @IBOutlet weak var avatarBaseView: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var genderSelectorBaseView: UIView!
    @IBOutlet weak var allTextFieldsBaseView: UIView!
    
    
    @IBOutlet weak var lcTitleTopSpace: NSLayoutConstraint!
    @IBOutlet weak var lcBtnContinueBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var lcBtnFbTopSpaceToTitle: NSLayoutConstraint!
    @IBOutlet weak var lcAvatartBaseTopSpaceToBtnFB: NSLayoutConstraint!
    @IBOutlet weak var lcGenderSelectorViewTopSpaceToAvatarBase: NSLayoutConstraint!
    @IBOutlet weak var lcAlltxtBaseTopSpaceToGenderSelcView: NSLayoutConstraint!
    
    
    
    let currentuserDetail = UserDetails()
    
    let dashLayer = CAShapeLayer()
    let bgColoredLayer = CAShapeLayer()
    
    var currentDateInDatePicker = Date()
    var selectedDate = Date().getDatePriorBy(yearsPrior: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        addDismissGesture()
        animateAndShowAllSubViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapBackButton(_ sender: Any) {
        dismissKeyBoard()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapFbAccessButton(_ sender: Any) {
        dismissKeyBoard()
        fetchDataFromFacebook()
    }
    
    @IBAction func didTapMaleButton(_ sender: Any) {
        dismissKeyBoard()
        currentuserDetail.gender = .male
        changeUIForGenderChange()
    }
    
    @IBAction func didTapFemaleButton(_ sender: Any) {
        dismissKeyBoard()
        currentuserDetail.gender = .female
        changeUIForGenderChange()
    }
    
    @IBAction func didTapDateOfBirthSection(_ sender: Any) {
        dismissKeyBoard()
        showDateOfBirthPickerView()
    }
    
    @IBAction func didTapAvatarButton(_ sender: Any) {
        dismissKeyBoard()
        showImagePicker()
    }
    
    @IBAction func didTapContinueButton(_ sender: Any) {
    }
    
}


extension AMUserDetailsEntryController {
    func prepareView() {
        setScreenTitle(title: "Basic profile", animationDuration: 0.0)
        
        btnFBAcess.layer.cornerRadius = 4.0
        btnContinue.layer.cornerRadius = 4.0
        
        setGenderLabelSelected(label: lblMale, isSelected: false)
        setGenderLabelSelected(label: lblFemale, isSelected: true)
        setAttributtedPlaceholder(textFiled: txtFirstName, placeholder: "FIRST NAME")
        setAttributtedPlaceholder(textFiled: txtLastName, placeholder: "LAST NAME")
        setAttributtedPlaceholder(textFiled: txtDateOfBirth, placeholder: "DATE OF BIRTH")
        
        imgCalendar.image = #imageLiteral(resourceName: "Calendar").withRenderingMode(.alwaysTemplate)
        imgCalendar.tintColor = AMWhite2
        
        txtFirstName.delegate = self
        txtLastName.delegate = self
        txtDateOfBirth.delegate = self
        
        let lineDashPatterns:[NSNumber] = [5,5]
        
        let circularPath = UIBezierPath.init(arcCenter: CGPoint(x:avatarBaseView.bounds.width/2,y:avatarBaseView.bounds.width/2), radius: avatarBaseView.bounds.width/2, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        
        let circularPathInner = UIBezierPath.init(arcCenter: CGPoint(x:avatarBaseView.bounds.width/2,y:avatarBaseView.bounds.width/2), radius: (avatarBaseView.bounds.width/2)-1, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        
        dashLayer.path = circularPath.cgPath
        dashLayer.fillColor = UIColor.clear.cgColor
        dashLayer.strokeColor = AMPinkishGrey.cgColor
        dashLayer.lineWidth = 2.0
        dashLayer.lineCap = kCALineCapSquare
        dashLayer.lineDashPattern = lineDashPatterns
        avatarBaseView.layer.addSublayer(dashLayer)
        
        bgColoredLayer.path = circularPathInner.cgPath
        bgColoredLayer.fillColor = AMWhite30.cgColor
        bgColoredLayer.strokeColor = UIColor.clear.cgColor
        avatarBaseView.layer.addSublayer(bgColoredLayer)
    }
    
    func setScreenTitle(title:String, animationDuration:Double) {
        DispatchQueue.main.async {
            let titleAttrStr = NSMutableAttributedString(string: title)
            titleAttrStr.addAttribute(.backgroundColor, value: AMPumpkinOrange, range: NSRange(location: 0, length: 5))
//            self.lblTitle.animateFade(duration: animationDuration)
            self.lblTitle.attributedText = titleAttrStr
        }
    }
    
    func changeUIForGenderChange() {
        if currentuserDetail.gender == .male {
            setGenderLabelSelected(label : lblMale, isSelected: true)
            setGenderLabelSelected(label: lblFemale, isSelected: false)
        }
        else if currentuserDetail.gender == .female {
            setGenderLabelSelected(label: lblMale, isSelected: false)
            setGenderLabelSelected(label: lblFemale, isSelected: true)
        }
    }
    
    func setGenderLabelSelected(label:UILabel, isSelected:Bool) {
        var color = AMWhite2
        if isSelected {
            color = UIColor.black
        }
        label.textColor = color
    }
    
    func setAttributtedPlaceholder(textFiled:UITextField, placeholder:String) {
        let placeHolderAttr = NSMutableAttributedString.init(string: placeholder)
        let placeHolderRange = NSRange.init(location: 0, length: placeholder.count)
        placeHolderAttr.addAttribute(.foregroundColor, value: AMWarmGrey2, range: placeHolderRange)
        placeHolderAttr.addAttribute(.font, value: Utilities.appThemeFont(size: 12), range: placeHolderRange)
        textFiled.attributedPlaceholder = placeHolderAttr
    }
    
    @objc func keyboardWillChangeFrame(_ notification: Notification) {
        let endFrame = ((notification as NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        if endFrame.origin.y != SCREEN_HEIGHT {//Keyboard present for textview
            lcTitleTopSpace.constant = 50.0 - endFrame.height + 32.0
            lcBtnContinueBottomSpace.constant = endFrame.height
        }
        else {//Keyboard dismissed for textview
            lcTitleTopSpace.constant = 50.0
            lcBtnContinueBottomSpace.constant = 32.0
        }
        view.layoutIfNeeded()
    }
    
    func showDateOfBirthPickerView() {
        let alertControl = UIAlertController(title: "DATE OF BIRTH", message: "Pick a Date", preferredStyle: .alert)
        
        alertControl.addDatePicker(mode: .date, date: selectedDate, minimumDate: Date().getDatePriorBy(yearsPrior: 100), maximumDate: Date().getDatePriorBy(yearsPrior: 10)) { (selectedDate) in
            self.currentDateInDatePicker = selectedDate
        }
        
        let doneAction = UIAlertAction.init(title: "Done", style: .cancel) { (action) in
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = APP_THEME_DATEFORMAT
            self.selectedDate = self.currentDateInDatePicker
            
            DispatchQueue.main.async {
                self.txtDateOfBirth.animateFade(duration: 0.5)
                self.txtDateOfBirth.text = dateFormatter.string(from: self.selectedDate)
                self.currentuserDetail.dateOfBirth = dateFormatter.string(from: self.selectedDate)
            }
        }
        
        alertControl.addAction(doneAction)
        alertControl.show()
    }
    
    func showImagePicker() {
        print("showImagePicker called...")
        
        let fusuma = FusumaViewController()
        fusuma.delegate = self
        
        fusumaCameraRollTitle = "Photos"
        fusumaCameraTitle = "Camera" // Camera Title
        fusumaTintColor =  AMPerfectBlack // tint color
        fusumaBaseTintColor = AMWarmGrey2
        fusumaBackgroundColor = UIColor.white
        fusumaTitleFont = Utilities.appThemeFont(size: 18)
        
        fusuma.defaultMode = .library
        fusuma.hasVideo = false //To allow for video capturing with .library and .camera available by default
        fusuma.cropHeightRatio = 1 // Height-to-width ratio. The default value is 1, which means a squared-size photo.
        fusuma.allowMultipleSelection = false // You can select multiple photos from the camera roll. The default value is false.
        
        self.present(fusuma, animated: true, completion: nil)
    }
    
    func fetchDataFromFacebook() {
        //Even if the user is already logged in via facebook, and the app already holds the facebook access token, we make the user login with facebook.
        //This is meant for adding user experiance to this page. In real app development we have to consider the possibility of the app holding the facebok access token before hand!
        
        FacebookHelper.login(fromViewControler: self) { (responseModel, errorMessage) in
            if let errorMessage = errorMessage {
                self.showErrorHud(position: .top, message: errorMessage, bgColor: .red, isPermanent: false)
            }
            else {
                self.imgAvatar.am_setImage(urlString: (responseModel?.getPicUrlStringWithFrame(width: Int(self.imgAvatar.frame.width), height: Int(self.imgAvatar.frame.height)))!, imageStyle: .rounded)
                self.imgAvatar.superview?.bringSubview(toFront: self.imgAvatar)
                self.txtFirstName.animateFade(duration: 0.5)
                self.txtLastName.animateFade(duration: 0.5)
                self.txtDateOfBirth.animateFade(duration: 0.5)
                self.txtFirstName.text = responseModel?.firstName
                self.txtLastName.text = responseModel?.lastName
                self.txtDateOfBirth.text = responseModel?.birthday
                
                self.currentuserDetail.avatarURL = responseModel?.getPicUrlStringWithFrame(width: Int(self.imgAvatar.frame.width), height: Int(self.imgAvatar.frame.height)) ?? ""
                self.currentuserDetail.firstName = responseModel?.firstName ?? ""
                self.currentuserDetail.lastName = responseModel?.lastName ?? ""
                self.currentuserDetail.dateOfBirth = responseModel?.birthday ?? ""
                self.currentuserDetail.gender = (responseModel?.gender) ?? .notSpecified
                self.changeUIForGenderChange()
                
                self.currentuserDetail.facebookModel = responseModel
            }
        }
    }
}

extension AMUserDetailsEntryController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFirstName {
            currentuserDetail.firstName = textField.text ?? ""
            txtLastName.becomeFirstResponder()
        }
        else if textField == txtLastName {
            dismissKeyBoard()
            currentuserDetail.lastName = textField.text ?? ""
            showDateOfBirthPickerView()
        }
        else {
            dismissKeyBoard()
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let currentText = textField.text {
            let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
            
            if textField == txtFirstName {
                currentuserDetail.firstName = updatedText
            }
            else if textField == txtLastName {
                currentuserDetail.lastName = updatedText
            }
        }
        
        return true
    }
}

extension AMUserDetailsEntryController: FusumaDelegate {
    func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {
        imgAvatar.animateFade(duration: 0.5)
        imgAvatar.image = image
        imgAvatar.superview?.bringSubview(toFront: imgAvatar)
        imgAvatar.layer.cornerRadius = avatarBaseView.bounds.width/2
    }
    
    func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {
    }
    
    func fusumaVideoCompleted(withFileURL fileURL: URL) {
    }
    
    func fusumaCameraRollUnauthorized() {
        print("fusumaCameraRollUnauthorized!")
    }
}

extension AMUserDetailsEntryController {
    func animateAndShowAllSubViews() {
        
        var delay:Double = 0.0
        let delayGap:Double = 0.15
        let duration:Double = 1.0
        
        let alphaAnimationSettings = AlphaAnimationSettings(alphaFromValue: 0.0, alphaToValue: 1.0)
        let springAnimationSettings = SpringAnimationSettings(damping: 0.75, initialSpringVelocity: 0.75)
        
        
        
        var animationLblTitleSettings = ConstraintAnimationSettings()
        animationLblTitleSettings.alphaAnimationSettings = alphaAnimationSettings
        animationLblTitleSettings.springAnimationSettings = springAnimationSettings
        animationLblTitleSettings.viewToAnimate = lblTitle
        animationLblTitleSettings.constraintToAnimate = lcTitleTopSpace
        animationLblTitleSettings.constraintInitialValue = lcTitleTopSpace.constant + SCREEN_HEIGHT
        animationLblTitleSettings.constraintFinalValue = lcTitleTopSpace.constant
        animationLblTitleSettings.animationSettings = .custom(animationDuration: duration, animationDelay: delay, animationOptions: .curveEaseOut)
        
        delay += delayGap
        var animationBtnFBSettings = ConstraintAnimationSettings()
        animationBtnFBSettings.alphaAnimationSettings = alphaAnimationSettings
        animationBtnFBSettings.springAnimationSettings = springAnimationSettings
        animationBtnFBSettings.viewToAnimate = btnFBAcess
        animationBtnFBSettings.constraintToAnimate = lcBtnFbTopSpaceToTitle
        animationBtnFBSettings.constraintInitialValue = lcBtnFbTopSpaceToTitle.constant + SCREEN_HEIGHT
        animationBtnFBSettings.constraintFinalValue = lcBtnFbTopSpaceToTitle.constant
        animationBtnFBSettings.animationSettings = .custom(animationDuration: duration, animationDelay: delay, animationOptions: .curveEaseOut)
        
        delay += delayGap
        var animationAvatarSettings = ConstraintAnimationSettings()
        animationAvatarSettings.alphaAnimationSettings = nil//alphaAnimationSettings
        animationAvatarSettings.springAnimationSettings = springAnimationSettings
        animationAvatarSettings.viewToAnimate = avatarBaseView
        animationAvatarSettings.constraintToAnimate = lcAvatartBaseTopSpaceToBtnFB
        animationAvatarSettings.constraintInitialValue = lcAvatartBaseTopSpaceToBtnFB.constant + SCREEN_HEIGHT
        animationAvatarSettings.constraintFinalValue = lcAvatartBaseTopSpaceToBtnFB.constant
        animationAvatarSettings.animationSettings = .custom(animationDuration: duration, animationDelay: delay, animationOptions: .curveEaseOut)
        
        delay += delayGap
        var animationGenderSelSettings = ConstraintAnimationSettings()
        animationGenderSelSettings.alphaAnimationSettings = alphaAnimationSettings
        animationGenderSelSettings.springAnimationSettings = springAnimationSettings
        animationGenderSelSettings.viewToAnimate = avatarBaseView
        animationGenderSelSettings.constraintToAnimate = lcGenderSelectorViewTopSpaceToAvatarBase
        animationGenderSelSettings.constraintInitialValue = lcGenderSelectorViewTopSpaceToAvatarBase.constant + SCREEN_HEIGHT
        animationGenderSelSettings.constraintFinalValue = lcGenderSelectorViewTopSpaceToAvatarBase.constant
        animationGenderSelSettings.animationSettings = .custom(animationDuration: duration, animationDelay: delay, animationOptions: .curveEaseOut)
        
        delay += delayGap
        var animationTxtbaseSettings = ConstraintAnimationSettings()
        animationTxtbaseSettings.alphaAnimationSettings = alphaAnimationSettings
        animationTxtbaseSettings.springAnimationSettings = springAnimationSettings
        animationTxtbaseSettings.viewToAnimate = avatarBaseView
        animationTxtbaseSettings.constraintToAnimate = lcAlltxtBaseTopSpaceToGenderSelcView
        animationTxtbaseSettings.constraintInitialValue = lcAlltxtBaseTopSpaceToGenderSelcView.constant + SCREEN_HEIGHT
        animationTxtbaseSettings.constraintFinalValue = lcAlltxtBaseTopSpaceToGenderSelcView.constant
        animationTxtbaseSettings.animationSettings = .custom(animationDuration: duration, animationDelay: delay, animationOptions: .curveEaseOut)
        
        delay += delayGap
        var animationBtnContinueSettings = ConstraintAnimationSettings()
        animationBtnContinueSettings.alphaAnimationSettings = alphaAnimationSettings
        animationBtnContinueSettings.springAnimationSettings = springAnimationSettings
        animationBtnContinueSettings.viewToAnimate = btnContinue
        animationBtnContinueSettings.constraintToAnimate = lcBtnContinueBottomSpace
        animationBtnContinueSettings.constraintInitialValue = lcBtnContinueBottomSpace.constant - SCREEN_HEIGHT
        animationBtnContinueSettings.constraintFinalValue = lcBtnContinueBottomSpace.constant
        animationBtnContinueSettings.animationSettings = .custom(animationDuration: duration, animationDelay: delay, animationOptions: .curveEaseOut)
        
        let animations = [animationLblTitleSettings,animationBtnFBSettings,animationAvatarSettings,animationGenderSelSettings,animationTxtbaseSettings,animationBtnContinueSettings]
        AMAnimator.animateAllConstraints(allanimationConstraints: animations)
    }
}
