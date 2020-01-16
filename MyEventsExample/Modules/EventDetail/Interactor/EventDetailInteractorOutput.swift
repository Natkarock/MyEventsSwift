//
//  EventDetailEventDetailInteractorOutput.swift
//  MyEventsExample
//
//  Created by Natalya Karapats on 20/07/2018.
//  Copyright © 2018 natateam. All rights reserved.
//

import Foundation

protocol EventDetailInteractorOutput: class {
    func succesAction()
    func showError(message: String)
}
