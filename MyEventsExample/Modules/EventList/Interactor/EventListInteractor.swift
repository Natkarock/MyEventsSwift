//
//  EventListEventListInteractor.swift
//  MyEventsExample
//
//  Created by Natalya Karapats on 19/07/2018.
//  Copyright © 2018 natateam. All rights reserved.
//

class EventListInteractor<T:DocumentSerializable>: EventListInteractorInput {

    weak var output: EventListInteractorOutput!
    
    func getEntitiesByType(type: TargetFType) {
        DataManager().getEntitiesBytype(type: type, onSuccess:
            {(events:[T]) in
                self.output.setEvents(events: events)
        },
                                        
                                        onFailure: {})
    }
}

