//
//  EventListEventListViewInput.swift
//  MyEventsExample
//
//  Created by Natalya Karapats on 19/07/2018.
//  Copyright © 2018 natateam. All rights reserved.
//
import UIKit
protocol EventListViewInput: class {

    /**
        @author Natalya Karapats
        Setup initial state of the view
    */

    func setupInitialState()
    func setEvents(events:[DocumentSerializable])
    func getEntitiesByType(type: TargetFType)
    func goToDetailVC(tasktype: FCollectiontype, data: DocumentSerializable)
    func getNavigationController() -> UINavigationController?
  
}
