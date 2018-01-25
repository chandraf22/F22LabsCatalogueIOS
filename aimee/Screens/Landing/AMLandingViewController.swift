//
//  AMLandingViewController.swift
//  aimee
//
//  Created by Chandrachudh on 18/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import UIKit

class AMLandingViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    
    let dataSource = [["type" : "AUTHENTICATION PAGES","items":[ScreenType.kAuthType1]],["type" : "USER DATA ENTRY PAGES","items":[ScreenType.kUserDetailsEntryType1]],["type" : "INTEREST SELECTION PAGES","items":[ScreenType.kInterestType1]],["type" : "ACCOMPLISHMENTS PAGES","items":[ScreenType.kAccomplishmentsType1]]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ALL PAGES"
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
        }
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupTableView() {
        let nib = UINib.init(nibName: AMLandingViewCell.reuseIdentifier(), bundle: nil)
        myTableView.register(nib, forCellReuseIdentifier: AMLandingViewCell.reuseIdentifier())
        
        myTableView.estimatedRowHeight = 40.0
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.tableFooterView = UIView()
        
        myTableView.reloadData()
    }
}

extension AMLandingViewController:UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: self.tableView(tableView, heightForHeaderInSection: section)))
        headerView.backgroundColor = UIColor.rgb(fromHex: 0xf5f5f5)
        
        let lblTitle = UILabel.init(frame: CGRect(x: 32, y: 0, width: SCREEN_WIDTH - 64, height: headerView.frame.height))
        lblTitle.font = UIFont.boldSystemFont(ofSize: 20)
        if currentDeviceType == .iPhone5 {
            lblTitle.font = UIFont.boldSystemFont(ofSize: 16)
        }
        lblTitle.textColor = UIColor.black
        lblTitle.textAlignment = .left
        headerView.addSubview(lblTitle)
        
        lblTitle.text = (dataSource[section])["type"] as? String
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((dataSource[section])["items"] as! [ScreenType]).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AMLandingViewCell.reuseIdentifier(), for: indexPath) as! AMLandingViewCell
        cell.lblTitle.text = (((dataSource[indexPath.section])["items"] as! [ScreenType])[indexPath.row]).getTitle()
        if currentDeviceType == .iPhone5 {
            cell.lblTitle.font = cell.lblTitle.font.withSize(16)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.isNavigationBarHidden = true
        let selectedCellType = (((dataSource[indexPath.section])["items"] as! [ScreenType])[indexPath.row])
        navigationController?.pushViewController(selectedCellType.getViewController(), animated: true)
    }
}
