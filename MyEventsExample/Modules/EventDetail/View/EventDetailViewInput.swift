//
//  EventDetailEventDetailViewInput.swift
//  MyEventsExample
//
//  Created by Natalya Karapats on 20/07/2018.
//  Copyright © 2018 natateam. All rights reserved.
//

protocol EventDetailViewInput: class {

    /**
        @author Natalya Karapats
        Setup initial state of the view
    */

    func setupInitialState()
    func succesAction()
    func showError(message: String)

}
