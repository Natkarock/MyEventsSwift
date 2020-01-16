//
//  EventDetailEventDetailConfigurator.swift
//  MyEventsExample
//
//  Created by Natalya Karapats on 20/07/2018.
//  Copyright © 2018 natateam. All rights reserved.
//

import UIKit

class EventDetailModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? EventDetailViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: EventDetailViewController) {

        let router = EventDetailRouter()

        let presenter = EventDetailPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = EventDetailInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
