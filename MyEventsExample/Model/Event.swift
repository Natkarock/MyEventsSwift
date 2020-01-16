//
//  Event.swift
//  MyEventsExample
//
//  Created by Karapats on 31/05/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import Foundation

struct Event  {
    var  dateMs: Int
    var  desc: String
    var  eventId: String
    var  repeatDaysArray: String {
        get {
          var days = ""
          let daySymbols = DateFormatter().weekdaySymbols
          let dayIndexes = task_repeat_days.split(separator: " ")
            dayIndexes.forEach( {
                let index = Int($0) ?? -1
                if (index > -1 && index < (daySymbols?.count)!){
                    days += daySymbols![index] + " "
                }
            })
          return days
        }
    }
    var repestDaysIndexes : [Int] {
        get {
            var days:[Int] = []

            let dayIndexes = task_repeat_days.split(separator: " ")
            dayIndexes.forEach( {
                let index = Int($0) ?? -1
                if (index > -1){
                   days.append(index)
                }
            })
            return days
        }
    }
    var task_date: String
    var task_is_done:Bool
    var task_repeat_times:String
    var task_repeat_days:String
    var task_time: String
    var task_type:String
    var title:String
    var user_id: String
    
    var dictionary:[String:Any]{
        return [
        "dateMs":dateMs,
        "desc":desc,
        "event_id":eventId,
        "task_date": task_date,
        "task_is_done": task_is_done,
        "task_repeat_times": task_repeat_times,
        "task_repeat_days":task_repeat_days,
        "task_time": task_time,
        "task_type":task_type,
        "title": title,
        "user_id": user_id
        ]
    }
}


extension Event: DocumentSerializable{
    init?(dictionary: [String : Any]) {
            let dateMs = dictionary["dateMs"] as? Int  ?? 0
            let desc = dictionary["desc"] as? String  ?? ""
            let eventId = dictionary["event_id"] as? String ?? ""
            let task_date = dictionary["task_date"] as? String ?? ""
            let task_is_done = dictionary["task_is_done"] as? Bool ?? false
            let task_repeat_times = dictionary["task_repeat_times"] as? String  ?? ""
            let task_repeat_days = dictionary["task_repeat_days"] as? String ?? ""
            let task_time = dictionary["task_time"]as? String  ?? ""
            let task_type = dictionary["task_type"]as? String  ?? ""
            let title = dictionary ["title"] as? String  ?? ""
            let user_id = dictionary["user_id"] as? String ?? ""
        
        self.init(dateMs: dateMs,
                  desc: desc, eventId: eventId,  task_date: task_date , task_is_done: task_is_done, task_repeat_times: task_repeat_times, task_repeat_days: task_repeat_days, task_time: task_time, task_type: task_type, title: title, user_id: user_id)
    
    
}
}
