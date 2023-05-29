//
//  Date+Extensions.swift
//  TweetMD
//
//  Created by Kimberly Hsiao on 1/23/19.
//  Copyright © 2019 Doximity. All rights reserved.
//

import Foundation

extension Date {
    enum Constants {
        static let secondsInWeek: Double = 604800
        static let secondsInDay: Double = 86400
        static let secondsInHour: Double = 3600
        static let secondsInMinute: Double = 60
    }
    
    ///  Returns a short string to indicate how much time has passed
    ///  between the current datetime and the passed in datetime
    ///
    ///     ** 'just now' if less than 1 min ago
    ///     ** 1-59m for less than 1 hour ago
    ///     ** 1-23h for less than 1 day ago
    ///     ** 1-7d for less than 8 days ago
    ///     ** else, format the date e.g., 1/2/16
    ///
    /// - Parameter startDate: the starting datetime
    /// - Returns: a string representation of the time elapsed
    static func timeElapsedString(since startDate: Date) -> String {
        let now = Date()
        let secondsBeforeNow = now.secondsSince(date: startDate)
        let minutesBeforeNow = now.minutesSince(date: startDate)
        let hoursBeforeNow = now.hoursSince(date: startDate)
        let daysBeforeNow = now.daysSince(date: startDate)
        
        if secondsBeforeNow < 60 {
            return "just now"
        } else if minutesBeforeNow < 60 {
            return "\(Int(minutesBeforeNow))m"
        } else if hoursBeforeNow < 24 {
            return "\(Int(hoursBeforeNow))h"
        } else if daysBeforeNow < 7 {
            return "\(Int(daysBeforeNow))d"
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "M/d/yy"
            return formatter.string(from: startDate)
        }
    }
    
    /// Returns a full description string of the day, date, and time
    ///
    /// - Returns: e.g., Thursday, Jan 24, 2019 11:24 PM
    func fullDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy h:mm a"
        return formatter.string(from: self)
    }
    
    private func secondsSince(date startDate: Date) -> Double {
        return timeIntervalSince(startDate).rounded()
    }
    
    private func minutesSince(date startDate: Date) -> Double {
        return (timeIntervalSince(startDate) / Constants.secondsInMinute).rounded()
    }
    
    private func hoursSince(date startDate: Date) -> Double {
        return (timeIntervalSince(startDate) / Constants.secondsInHour).rounded()
    }
    
    private func daysSince(date startDate: Date) -> Double {
        return daysSince(date: startDate, calendar: Calendar.current).rounded()
    }
    
    private func daysSince(date startDate: Date, calendar: Calendar) -> Double {
        let earliest = startDate < self ? startDate : self
        let latest = startDate > self ? startDate : self
        let multiplier = earliest == self ? -1 : 1
        let components = calendar.dateComponents([.day], from: earliest, to: latest)
        return Double(multiplier * (components.day ?? 0))
    }
}
