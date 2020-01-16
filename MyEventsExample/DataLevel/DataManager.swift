//
//  DataManager.swift
//  MyEventsExample
//
//  Created by Karapats on 31/05/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import Foundation

final class DataManager
{
    func getEntitiesBytype<T:DocumentSerializable>(type:TargetFType,onSuccess:@escaping ([T])->(), onFailure: @escaping ()->()){
        dataProvider().getEntitiesByType(target:type , onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func getEntityById<T:DocumentSerializable>(type:TargetFType,id:String,onSuccess:@escaping (T)->(), onFailure: @escaping ()->()){
        dataProvider().getEntityById(target:type, id: id, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func setEntity(entity:DocumentSerializable?, target:TargetFType, onSuccess:@escaping ()->(), onFailure: @escaping (String)->()){
        dataProvider().setEntity(entity: entity, target: target, onSuccess: onSuccess, onFailure: onFailure)
    }
    func deleteEntity( id: String, target:TargetFType, onSuccess:@escaping ()->(), onFailure: @escaping (String)->())
    {
       dataProvider().deleteEntity(id: id, target: target, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    
    func dataProvider()->DataProvider{
        return FirebaseProvieder()
    }
    
}
