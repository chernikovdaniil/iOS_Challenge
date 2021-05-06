//
//  Date.swift
//  Boosters iOS Challenge
//
//  Created by Danil Chernikov on 06.05.2021.
//

import Foundation

extension Date {
    static func dateFromString(_ string: String, format: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.current
        formatter.timeZone = .current
        return formatter.date(from: string)
    }
    
    func convertToString(format: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.locale = Locale.current
        formatter.timeZone = .current
        return formatter.string(from: self)
    }
}
