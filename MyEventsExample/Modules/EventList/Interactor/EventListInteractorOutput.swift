//
//  EventListEventListInteractorOutput.swift
//  MyEventsExample
//
//  Created by Natalya Karapats on 19/07/2018.
//  Copyright © 2018 natateam. All rights reserved.
//

import Foundation

protocol EventListInteractorOutput: class {
    func setEvents(events:[DocumentSerializable])
}
