//
//  EventListEventListViewOutput.swift
//  MyEventsExample
//
//  Created by Natalya Karapats on 19/07/2018.
//  Copyright © 2018 natateam. All rights reserved.
//

protocol EventListViewOutput {

    /**
        @author Natalya Karapats
        Notify presenter that view is ready
    */

    func viewIsReady()
    func getEntitiesByType(type: TargetFType)
    func goToDetailVC(tasktype: FCollectiontype, data: DocumentSerializable)
}
