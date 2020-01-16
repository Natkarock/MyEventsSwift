//
//  Birthday.swift
//  MyEventsExample
//
//  Created by Karapats on 01/06/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import Foundation

struct Contact{
    
    var need_alarm: Bool
    var contact_birthday: String
    var contact_date_ms: Int
    var contact_email: String
    var contact_google_id: String
    var contact_group:String
    var contact_id: String
    var contact_name: String
    var contact_phone: String
    var contact_time: String
    var user_id:String
    
    var dictionary: [String: Any]{
        return ["need_alarm": need_alarm,
                "contact_birthday": contact_birthday,
                "contact_date_ms": contact_date_ms,
                "contact_email": contact_email,
                "contact_google_id":contact_google_id,
                "contact_group":contact_group,
                "contact_id": contact_id,
                "contact_name":contact_name,
                "contact_phone":contact_phone,
                "contact_time": contact_time,
                "user_id":user_id
        ]
    }
    

}

extension Contact: DocumentSerializable{
    
    init?(dictionary: [String : Any]) {
        let need_alarm = dictionary["need_alarm"] as? Bool ?? false
        let contact_birthday = dictionary["contact_birthday"] as? String ?? ""
        let contact_date_ms = dictionary["contact_date_ms"] as? Int ?? 0
        let contact_email = dictionary["contact_email"] as? String ?? ""
        let contact_google_id = dictionary["contact_google_id"] as? String ?? ""
        let contact_group = dictionary["contact_group"] as? String ?? ""
        let contact_id = dictionary["contact_id"] as? String ?? ""
        let contact_name = dictionary ["contact_name"] as? String ?? ""
        let contact_phone = dictionary["contact_phone"] as? String ?? ""
        let contact_time = dictionary["contact_time"] as? String ?? ""
        let user_id = dictionary["user_id"] as? String ?? ""
        
        self.init(need_alarm: need_alarm, contact_birthday: contact_birthday, contact_date_ms: contact_date_ms, contact_email: contact_email, contact_google_id:  contact_google_id, contact_group: contact_group, contact_id: contact_id, contact_name: contact_name, contact_phone: contact_phone, contact_time: contact_time , user_id: user_id)
        
        
    }
    
}
