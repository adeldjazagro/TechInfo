//
//  File.swift
//  TechInfo
//
//  Created by Adel on 21/05/2019.
//  Copyright © 2019 Adel. All rights reserved.
//

import Foundation

extension NSDate {
    
    func getDateString() -> String {
    let calendar = Calendar.current
        let month = calendar.component(.month, from: self as Date)
        let day = calendar.component(.day, from: self as Date)
        let year = calendar.component(.year, from: self as Date)
        return "\(day)/\(month)/\(year)"
        
    }
}

extension Int {
    func formatTimeToString() -> String {
        let durationHours = self / 3600
        let durationMinutes = (self % 3600) / 60
        let durationSecondes = (self % 3600) % 60
        
        if durationSecondes < 0 {
            return "00:00:00"
        } else {
            if durationHours == 0 {
                return String(format: "%02d:%02d", durationMinutes, durationSecondes)
            } else {
                return String(format: "%02d:%02d:%02d",durationHours, durationMinutes, durationSecondes)
            }
        }
    }
}
