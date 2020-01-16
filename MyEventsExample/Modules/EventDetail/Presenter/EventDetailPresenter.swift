//
//  EventDetailEventDetailPresenter.swift
//  MyEventsExample
//
//  Created by Natalya Karapats on 20/07/2018.
//  Copyright © 2018 natateam. All rights reserved.
//

class EventDetailPresenter: EventDetailModuleInput, EventDetailViewOutput, EventDetailInteractorOutput {

    weak var view: EventDetailViewInput!
    var interactor: EventDetailInteractorInput!
    var router: EventDetailRouterInput!

    func viewIsReady() {
        view.setupInitialState()
    }
    
    func deleteData(data: DocumentSerializable, type: TargetFType) {
        interactor.deleteData(data: data, type: type)
    }
    
    func updateData(data: DocumentSerializable, type: TargetFType) {
        interactor.updateData(data: data, type: type)
    }
    
    func showError(message: String) {
        view.showError(message: message)
    }
    
    func succesAction() {
        view.succesAction()
    }
}
