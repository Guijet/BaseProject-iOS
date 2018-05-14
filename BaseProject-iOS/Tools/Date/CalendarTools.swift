//
//  CalendarTools.swift
//  ArtifexApp
//
//  Created by Guillaume Jette on 2017-12-10.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return abs(Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0)
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return abs(Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0)
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return abs(Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0)
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return abs(Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0)
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return abs(Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0)
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return abs(Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0)
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return abs(Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0)
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
    
    func daysBetween(date: Date) -> Int {
        return Date.daysBetween(start: self, end: date)
    }
    
    static func daysBetween(start: Date, end: Date) -> Int {
        let calendar = Calendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: start)
        let date2 = calendar.startOfDay(for: end)
        
        let a = calendar.dateComponents([.day], from: date1, to: date2)
        return a.value(for: .day)!
    }
    
    func fromNow(nbDays:Int)->Date{
        return (Calendar.current as NSCalendar).date(byAdding: .day, value: -nbDays, to: Date(), options: [])!
    }
}

extension String{
    func isBetweeen(date1: String, date2: String) -> Bool {
        return date1.stringToDate().compare(self.stringToDate()) == self.stringToDate().compare(date2.stringToDate())
    }
    
    func isBetweeenInclusive(date1: String, date2: String) -> Bool {
        return date1.stringToDate().compare(self.stringToDate()).rawValue * self.stringToDate().compare(date2.stringToDate()).rawValue >= 0
    }
    
    func stringToDate()->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self)!
    }
}

