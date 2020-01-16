//
//  TargetFType.swift
//  MyEventsExample
//
//  Created by Karapats on 31/05/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import Foundation
protocol  TargetFType {
    var name: String {get}
    var type: String {get}
    var allEntityParams: [String:Any]{get}
    var idParam:String{get}
}
