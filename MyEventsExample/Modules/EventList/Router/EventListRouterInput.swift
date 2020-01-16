//
//  EventListEventListRouterInput.swift
//  MyEventsExample
//
//  Created by Natalya Karapats on 19/07/2018.
//  Copyright © 2018 natateam. All rights reserved.
//

import Foundation
import UIKit

protocol EventListRouterInput {
    func gotoEventDetail(view: EventListViewInput, tasktype: FCollectiontype, data: DocumentSerializable)
}
