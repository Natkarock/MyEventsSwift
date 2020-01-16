//
//  EventDetailEventDetailViewOutput.swift
//  MyEventsExample
//
//  Created by Natalya Karapats on 20/07/2018.
//  Copyright © 2018 natateam. All rights reserved.
//

protocol EventDetailViewOutput {

    /**
        @author Natalya Karapats
        Notify presenter that view is ready
    */

    func viewIsReady()
    func updateData(data: DocumentSerializable, type: TargetFType)
    func deleteData(data: DocumentSerializable, type:TargetFType)
}
