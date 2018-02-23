//
//  DateExtension.swift
//  aimee
//
//  Created by Chandrachudh on 24/01/18.
//  Copyright © 2018 F22Labs. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    
    func getDatePriorBy(yearsPrior:Int)->Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = -1 * yearsPrior
        
        let givenDateInSeconds:Double = self.timeIntervalSince1970
        let years13InSeconds:Double = Double(60 * 60 * 24 * 365 * yearsPrior)
        let requiredDateInSeconds = givenDateInSeconds - years13InSeconds
        let newDate = Date.init(timeIntervalSince1970: requiredDateInSeconds)
        
        // max date
        return (calendar as NSCalendar).date(byAdding: components, to: self, options: []) ?? newDate
    }
    
    func getAgeFromDate()->Int {
        return 10
    }
}
