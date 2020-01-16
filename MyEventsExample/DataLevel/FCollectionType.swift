//
//  FCollectionType.swift
//  MyEventsExample
//
//  Created by Karapats on 31/05/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import Foundation
enum FCollectiontype {
    case events
    case alarms
    case contacts
}

extension FCollectiontype : TargetFType {
    
    public var idParam: String {
        switch self {
        case .events,.alarms:
            return "event_id"
        case .contacts:
            return "contact_id"
        }
    }
    
    
    
    
    
    
    
    
    public var allEntityParams: [String : Any] {
        switch self {
        case .events:
            return ["task_type": "todo"]
        case .alarms: return ["task_type": "repeat"]
        default:
            return [:]
        }
    }
    
    
    
    public var type: String {
        switch self {
        case .events:
            return "todo"
        case  .alarms:
            return "repeat"
        case  .contacts:
            return "birthday"
        }
    }
    
    public var name: String {
        switch self {
        case .events,.alarms:
            return "events"
        case .contacts:
            return "contacts"
        }
    }
    
    
}

