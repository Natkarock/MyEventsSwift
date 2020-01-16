//
//  Utils.swift
//  MyEventsExample
//
//  Created by Karapats on 04/06/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import Foundation

extension Date {
    
    // -> Date System Formatted Medium
    func ToDateMediumString() -> NSString? {    
        let formatter = DateFormatter()
        formatter.dateStyle = .medium;
        formatter.timeStyle = .none;
        return formatter.string(from: self) as NSString
    }
    
    func formatForDay() -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd.MM.yyyy"
        let dateString = self
        return  dateFormatterGet.string(from: dateString)
    }
    
    func formatForTime() -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "HH:mm"
        let dateString = self
        return  dateFormatterGet.string(from: dateString)
    }
    
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
}


extension NSObject {
    func formatDateWith(string:String) -> Date{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd.MM.yyyy HH:mm"
        dateFormatterGet.timeZone = TimeZone.current
        var date = Date()
        if string != "" {
            //do {
            date = dateFormatterGet.date(from: string) ?? Date()
            //}catch {
              //  print("incorrect date format")
            //}
        }
        //print(dateFormatterGet.string(from: date))
        return date
    }
    
    
    func formatDate(dateMillis:Int) -> String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd.MM.yyyy  HH:mm"
        let dateString = Date(timeIntervalSince1970: TimeInterval(dateMillis)/1000)
        return  dateFormatterGet.string(from: dateString)
    }
}



