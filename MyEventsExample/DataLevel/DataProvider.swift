//
//  DataProvider.swift
//  MyEventsExample
//
//  Created by Karapats on 31/05/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import Foundation

protocol DataProvider{
    func getEntitiesByType<T:DocumentSerializable>(target:TargetFType,onSuccess:@escaping ([T])->(), onFailure: @escaping ()->())
    func getEntityById<T:DocumentSerializable>(target:TargetFType,id:String,onSuccess:@escaping (T)->(), onFailure: @escaping ()->())
    func setEntity(entity:DocumentSerializable?, target:TargetFType, onSuccess:@escaping ()->(), onFailure: @escaping (String)->())
    func deleteEntity(id: String, target:TargetFType, onSuccess:@escaping ()->(), onFailure: @escaping (String)->())
}
