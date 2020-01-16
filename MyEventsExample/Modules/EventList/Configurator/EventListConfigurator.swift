//
//  EventListEventListConfigurator.swift
//  MyEventsExample
//
//  Created by Natalya Karapats on 19/07/2018.
//  Copyright © 2018 natateam. All rights reserved.
//

import UIKit

class EventListModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController, tasktype: FCollectiontype) {

        if let viewController = viewInput as? EventListViewController {
            configure(viewController: viewController,tasktype: tasktype)
        }
    }

    private func configure(viewController: EventListViewController,tasktype: FCollectiontype) {

        let router = EventListRouter()
        let presenter = EventListPresenter()
        presenter.view = viewController
        presenter.router = router
        var  interactor: EventListInteractorInput? = nil
        if tasktype == .contacts{
           interactor = EventListInteractor<Contact>()
          (interactor as! EventListInteractor<Contact>).output = presenter
        }else {
           interactor = EventListInteractor<Event>()
           (interactor as! EventListInteractor<Event>).output = presenter
        }

        presenter.interactor = interactor
        viewController.presenter = presenter
    }

}
