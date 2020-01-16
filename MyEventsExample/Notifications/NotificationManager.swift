//
//  NotificationManager.swift
//  MyEventsExample
//
//  Created by Karapats on 05/06/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import Foundation
import UserNotifications

protocol NotificationManager{
    func setAlarms()
    func setAlarmForDocument(data:DocumentSerializable)
    func deleteAlarmForDocument(data:DocumentSerializable)
    func deleteAllAlarms()
}

final class LocalNotificationManager: NSObject, NotificationManager {

    
    
    static let sharedInstance = LocalNotificationManager()
    
    override init() {
        super.init()
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert,.sound])
        {
            (granted, error) in
            //self.notificationGranted = granted
            if let error = error {
                print("granted, but Error in notification permission:\(error.localizedDescription)")
            }
        }
        UNUserNotificationCenter.current().delegate = self
    }
    
    
    
    
    func setAlarms() {
        DispatchQueue.global(qos: .utility).async {
            self.deleteAllAlarms()
            DataManager().getEntitiesBytype(type: FCollectiontype.events, onSuccess: {(events:[Event]) in
                events.forEach({self.setAlarmForDocument(data: $0)})
            }, onFailure: {})
            DataManager().getEntitiesBytype(type: FCollectiontype.alarms, onSuccess: {(events:[Event]) in
                events.forEach({self.setAlarmForDocument(data: $0)})
            }, onFailure: {})
            DataManager().getEntitiesBytype(type: FCollectiontype.contacts, onSuccess: {(events:[Contact]) in
                events.forEach({self.setAlarmForDocument(data: $0)})
            }, onFailure: {})
        }
        //testNotification()
    }
    
    
    func testNotification(){
        let center =  UNUserNotificationCenter.current()
        //create the content for the notification
        let content = UNMutableNotificationContent()
        content.title = " Jurassic Park"
        content.subtitle = "Lunch"
        content.body = "Its lunch time at the park, please join us for a dinosaur feeding"
        content.sound = UNNotificationSound.default()
        
        //notification trigger can be based on time, calendar or location
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:10.0, repeats: false)
        
        //create request to display
        let request = UNNotificationRequest(identifier: "ContentIdentifier", content: content, trigger: trigger)
        
        //add request to notification center
        center.add(request) { (error) in
            if error != nil {
                print("error \(String(describing: error))")
            }
        }
    }
    
    
    
    
    func setAlarmForDocument(data: DocumentSerializable) {
        var requests: [UNNotificationRequest] = []
        if data is Event {
            let event = data as! Event
            if event.task_type == "todo"{
                if let request = getEventTodoAlarmRequest(event: event) {
                    requests.append(request)
                }
            }else if event.task_type == "repeat" {
                requests += getEventRepeatRequests(event: event)
            }
        }else if data is Contact {
            let contact = data as! Contact
            let request = getContactRepeatRequest(contact: contact)
            requests.append(request)
        }
        requests.forEach({
            UNUserNotificationCenter.current().add($0) { (error) in
                if let error = error {
                    print("error in pizza reminder: \(error.localizedDescription)")
                }
            }
            print("added notification:\($0.identifier)")
        })
    }
    
    
    
    func getEventTodoAlarmRequest(event: Event)-> UNNotificationRequest?{
        let content = UNMutableNotificationContent()
        content.title = "MyEvents"
        content.body = event.title
        content.categoryIdentifier = event.task_type
        let timeInterval = formatDateWith(string: event.task_date + " " +  event.task_time).timeIntervalSinceNow
        if timeInterval < 0 {
            return nil
        }
        print("timeInterval: \(timeInterval)")
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval:timeInterval,
            repeats: false)
        let request = UNNotificationRequest(identifier: event.eventId, content: content, trigger: trigger)
        return request
    }
    
    func getEventRepeatRequests(event:Event) -> [UNNotificationRequest]{
        var requests:[UNNotificationRequest] = []
        event.repestDaysIndexes.forEach({
            let content = UNMutableNotificationContent()
            content.title = "MyEvents"
            content.body = event.title
            content.categoryIdentifier = event.task_type
            var dateComponents = DateComponents()
            let date = formatDateWith(string: event.task_date + " " +  event.task_time)
            dateComponents.hour = Calendar.current.component(.hour, from: date)
            dateComponents.minute = Calendar.current.component(.minute, from: date)
            dateComponents.weekday = $0
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: dateComponents,
                repeats: true)
            let request = UNNotificationRequest(identifier: event.eventId, content: content, trigger: trigger)
            requests.append(request)
            
        })
        return requests
    }
    
    func getContactRepeatRequest(contact:Contact)->UNNotificationRequest{
        let content = UNMutableNotificationContent()
        content.title = "MyEvents"
        content.body = contact.contact_name
        content.categoryIdentifier = "birthday"
        var dateComponents = DateComponents()
        let date = formatDateWith(string: contact.contact_birthday + " " +  "9:00")
        dateComponents.hour = Calendar.current.component(.hour, from: date)
        dateComponents.minute = Calendar.current.component(.minute, from: date)
        dateComponents.year = Calendar.current.component(.year, from: date)
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true)
        let request = UNNotificationRequest(identifier: contact.contact_id, content: content, trigger: trigger)
        return request
    }
    
    func deleteAlarmForDocument(data: DocumentSerializable) {
        var identifier = ""
        switch data {
        case  is Event:
            identifier = (data as! Event).eventId
        case is Contact:
            identifier = (data as! Contact).contact_id
        default:
            break;
        }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    func deleteAllAlarms() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}

extension LocalNotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
}
