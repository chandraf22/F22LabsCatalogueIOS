//
//  AMUserDetailsEntryController.swift
//  aimee
//
//  Created by Chandrachudh on 23/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

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
    
    
    @IBOutlet weak var lcTitleTopSpace: NSLayoutConstraint!
    @IBOutlet weak var lcBtnContinueBottomSpace: NSLayoutConstraint!
    
    
    
    let currentuserDetail = UserDetails()
    
    let dashLayer = CAShapeLayer()
    let bgColoredLayer = CAShapeLayer()
    
    var currentDateInDatePicker = Date()
    var selectedDate = Date().getDatePriorBy(yearsPrior: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        prepareView()
        
        addDismissGesture()
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
        setGenderLabelSelected(label : lblMale, isSelected: true)
        setGenderLabelSelected(label: lblFemale, isSelected: false)
        currentuserDetail.gender = .male
    }
    
    @IBAction func didTapFemaleButton(_ sender: Any) {
        dismissKeyBoard()
        setGenderLabelSelected(label: lblMale, isSelected: false)
        setGenderLabelSelected(label: lblFemale, isSelected: true)
        currentuserDetail.gender = .female
    }
    
    @IBAction func didTapDateOfBirthSection(_ sender: Any) {
        dismissKeyBoard()
        showDateOfBirthPickerView()
    }
    
    @IBAction func didTapAvatarButton(_ sender: Any) {
        dismissKeyBoard()
        showImagePicker()
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
            self.lblTitle.animateFade(duration: animationDuration)
            self.lblTitle.attributedText = titleAttrStr
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
            dateFormatter.dateFormat = "EE, dd MMMM, yyyy"
            self.selectedDate = self.currentDateInDatePicker
            
            DispatchQueue.main.async {
                self.txtDateOfBirth.animateFade(duration: 0.5)
                self.txtDateOfBirth.text = dateFormatter.string(from: self.selectedDate)
            }
        }
        
        alertControl.addAction(doneAction)
        alertControl.show()
    }
    
    func showImagePicker() {
        print("showImagePicker called...")
    }
    
    func fetchDataFromFacebook() {
        print("fetchDataFromFacebook called...")
    }
}

extension AMUserDetailsEntryController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == txtFirstName {
            txtLastName.becomeFirstResponder()
        }
        else if textField == txtLastName {
            dismissKeyBoard()
            showDateOfBirthPickerView()
        }
        else {
            dismissKeyBoard()
        }
        
        return true
    }
}

class UserDetails: NSObject {
    var firstName = ""
    var lastName = ""
    var dateOfBirth = Date()
    var gender = Gender.female
    var avatar = UIImage()
    var email = ""
}
