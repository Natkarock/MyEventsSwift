//
//  EventDetailEventDetailInitializer.swift
//  MyEventsExample
//
//  Created by Natalya Karapats on 20/07/2018.
//  Copyright © 2018 natateam. All rights reserved.
//

import UIKit

class EventDetailModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var eventdetailViewController: EventDetailViewController!

    override func awakeFromNib() {

        let configurator = EventDetailModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: eventdetailViewController)
    }

}
