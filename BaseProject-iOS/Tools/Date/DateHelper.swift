//
//  DatePicker.swift
//  ArtifexApp
//
//  Created by Guillaume Jette on 2017-11-18.
//  Copyright © 2017 Guillaume Jette. All rights reserved.
//

import UIKit

class DateHelper{
    var weekDay = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"]
    var month = ["January","Febuary","March","April","May","June","July","August","September","October","November","December"]
    
    var monthAbreviation = ["Jan","Feb","Mar","Apr","May","June","July","Aug","Sept","Oct","Nov","Dec"]
    var dayAbreviation = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"]
    
    func getArrayMouths()->[String]{
        return month
    }
    
    func getArrayDays()->[String]{
        var array = [String]()
        for x in 1...31{
            array.append(String(x))
        }
        return array
    }
    
    func getHundredYearsFromNowStringArray()->[String]{
        var arrayString = [String]()
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: date)
        
        for x in 0...100{
            arrayString.append(String(year - x))
        }
        
        return arrayString
    }
    
    func setUpDatePicker(textField:UITextField,control:UIViewController,bgColor:UIColor,action:Selector,event:UIControlEvents){
        let datePickerView = UIDatePicker()
        datePickerView.backgroundColor = bgColor
        datePickerView.datePickerMode = .date
        textField.inputView = datePickerView
        datePickerView.addTarget(control, action: action, for: event)
    }
    
    func getAgeFromBirthDate(birthdate:String)->Int{
        let now = Date()
        let birthday: Date = stringToDate(dateS: birthdate)
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        let age = ageComponents.year!
        return age
    }
    
    func stringToDate(dateS:String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        let date = dateFormatter.date(from: dateS) //according to date format your date string
        return date!
    }
    
    func getDayOfWeek(date: String) -> String{
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.date(from: date)!
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: todayDate)
        let weekDayIndex = myComponents.weekday! - 1
        return self.weekDay[weekDayIndex]
    }
    
    func getCurrentDateSmallFormat()->String{
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return String(describing:formatter.string(from: Date()))
    }
    
    func getDayOfWeekAbr(date: String) -> String{
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.date(from: date)!
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: todayDate)
        let weekDayIndex = myComponents.weekday! - 1
        return self.dayAbreviation[weekDayIndex]
    }
    
    func getWeekIndexOfDay(date: String) -> Int{
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDate = formatter.date(from: date)!
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let myComponents = myCalendar.components(.weekday, from: todayDate)
        let weekDay = myComponents.weekday! - 1
        return weekDay
    }
    
    func getMonthFromDate(date:String)->String{
        let monthIndex = date.substring(from: 5, to: 7)
        let month = self.month[Int(monthIndex)! - 1]
        return month
    }
    
    func getMonthAbrvFromDate(date:String)->String{
        let monthIndex = date.substring(from: 5, to: 7)
        return self.monthAbreviation[Int(monthIndex)! - 1]
    }
    
    func getDayFromDate(date:String)->String{
        let day = date.substring(from: 8, to: 10)
        return "\(day)"
    }
    
    func getYearFromDate(date:String)->String{
        return date.substring(from: 0, to: 4)
    }
    
    func formatDate(date: String) -> String{
        var date = date
        let monthIndex = date.substring(from: 5, to: 7)
        let month = self.month[Int(monthIndex)! - 1]
        var day = date.substring(from: 8, to: 10)
        day = String(describing: Int(day)!)
        date = date.substring(from: 0, to: 10)
        return "\(getDayOfWeek(date: date)), \(day) \(month)"
    }
    
    func formatDateStringToEventsDate(date:String)->String{
        let fullDate:String = date.substring(from: 0, to: 10)
        let abrvDay:String = getDayOfWeekAbr(date: fullDate)
        let monthAbrv = getMonthAbrvFromDate(date:fullDate)
        let dayNumber:String = getDayFromDate(date: fullDate)
        let year:String = getYearFromDate(date:fullDate)
        
        return "\(abrvDay), \(dayNumber) \(monthAbrv) \(year)"
    }
    
    func getDateFormatDashboard()->String{
        var result = ""
        let now:String = String(describing:Date())
        result += getMonthAbrvFromDate(date: now)
        result += " \(getDayFromDate(date: now))."
        result += " \(getYearFromDate(date: now))"
        return result
    }
}
