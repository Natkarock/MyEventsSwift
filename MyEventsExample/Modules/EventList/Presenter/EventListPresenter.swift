//
//  EventListEventListPresenter.swift
//  MyEventsExample
//
//  Created by Natalya Karapats on 19/07/2018.
//  Copyright © 2018 natateam. All rights reserved.
//

class EventListPresenter: EventListModuleInput, EventListViewOutput, EventListInteractorOutput {

    weak var view: EventListViewInput!
    var interactor: EventListInteractorInput!
    var router: EventListRouterInput!

    func viewIsReady() {
        view.setupInitialState()
    }
    func getEntitiesByType(type: TargetFType) {
        interactor.getEntitiesByType(type: type)
    }
    
    func setEvents(events: [DocumentSerializable]) {
        view.setEvents(events: events)
    }
    
    func goToDetailVC(tasktype: FCollectiontype, data: DocumentSerializable) {
        router.gotoEventDetail(view: view, tasktype: tasktype, data: data)
    }
}
