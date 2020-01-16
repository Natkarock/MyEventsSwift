//
//  EventListEventListInitializer.swift
//  MyEventsExample
//
//  Created by Natalya Karapats on 19/07/2018.
//  Copyright © 2018 natateam. All rights reserved.
//

import UIKit

class EventListModuleInitializer: NSObject {

    //Connect with object on storyboard
    var tasktype = FCollectiontype.events
    @IBOutlet weak var eventlistViewController: EventListViewController!

    override func awakeFromNib() {
        //Bundle.main.loadNibNamed("EventList", owner: self, options: nil)
        let configurator = EventListModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: eventlistViewController, tasktype:tasktype)
    }

}
