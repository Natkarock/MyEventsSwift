//
//  EventListEventListRouter.swift
//  MyEventsExample
//
//  Created by Natalya Karapats on 19/07/2018.
//  Copyright © 2018 natateam. All rights reserved.
//

import  UIKit
class EventListRouter: EventListRouterInput {
 
    
    func gotoEventDetail(view: EventListViewInput, tasktype: FCollectiontype, data: DocumentSerializable) {
        let eventDetailVC =  UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EventDetailtVC") as! EventDetailViewController
        eventDetailVC.targetType = tasktype
        eventDetailVC.data = data
        view.getNavigationController()?.pushViewController(eventDetailVC, animated: true)
    }
    

}
