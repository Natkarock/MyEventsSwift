//
//  EventDetailEventDetailInteractor.swift
//  MyEventsExample
//
//  Created by Natalya Karapats on 20/07/2018.
//  Copyright © 2018 natateam. All rights reserved.
//

class EventDetailInteractor: EventDetailInteractorInput {

    weak var output: EventDetailInteractorOutput!

    func updateData(data: DocumentSerializable, type: TargetFType) {
        DataManager().setEntity(entity: data, target: type, onSuccess: {
            self.output.succesAction()
        }, onFailure: {
            err in
            LocalNotificationManager.sharedInstance.deleteAlarmForDocument(data: data)
            self.output.showError(message: err)
        })
    }
    
    func deleteData(data: DocumentSerializable, type: TargetFType) {
        var id = ""
        if data is Event {
            id = (data as! Event).eventId
        }else if data is Contact {
            id = (data as! Contact).contact_id
        }
        LocalNotificationManager.sharedInstance.deleteAlarmForDocument(data: data)
        DataManager().deleteEntity(id: id, target: type, onSuccess: {self.output.succesAction()}, onFailure: {
            err in self.output.showError(message: err)
        })
    }
}
