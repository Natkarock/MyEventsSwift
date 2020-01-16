//
//  FirebaseProvider.swift
//  MyEventsExample
//
//  Created by Karapats on 31/05/ 15.
//  Copyright © 2018 Karapats. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase
import FirebaseUI


class FirebaseProvieder: DataProvider {
    
    
    let db = Firestore.firestore()
    func getEntitiesByType<T:DocumentSerializable>(target: TargetFType, onSuccess: @escaping ([T]) -> (), onFailure: @escaping () -> ()) {
        let user = Auth.auth().currentUser
        let collection = db.collection(target.name)
        var query: Query? = collection
        target.allEntityParams.forEach({ query = query?.whereField($0, isEqualTo: $1)})
        print("currentMillis \(Date().millisecondsSince1970)")
        let currentTimeMillis = Date().millisecondsSince1970
        if target as? FCollectiontype == FCollectiontype.events {
            query = query?.whereField("dateMs", isGreaterThan: currentTimeMillis)
        }
        query?.whereField("user_id", isEqualTo: user?.uid)
            .addSnapshotListener(includeMetadataChanges: true){ (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    var list: [T] = []
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        if let event = T(dictionary: document.data()){
                            list.append(event)
                        }
                    }
                    onSuccess(list)
                }
        }
    }
    
    func getEntityById<T:DocumentSerializable>(target:TargetFType,id: String, onSuccess: @escaping (T) -> (), onFailure: @escaping () -> ()) {
        let docRef = db.collection(target.name).document(id)
        docRef.getDocument { (document, error) in
            if let event = document.flatMap({
                $0.data().flatMap({ (data) in
                    return T.init(dictionary: data)
                })
            }) {
                onSuccess(event)
                print("City: \(event)")
            } else {
                onFailure()
                print("Document does not exist")
            }
        }
    }
    
    
    func setEntity(entity data: DocumentSerializable?, target: TargetFType, onSuccess: @escaping () -> (), onFailure: @escaping (String) -> ()) {
        let docRef = db.collection(target.name)
        var ref:DocumentReference?
        var newData: DocumentSerializable? 
        if let `data` = data {
            if data is Event {
                var event = data as! Event
                if event.eventId == "" {
                    ref = docRef.document()
                    event.eventId = (ref?.documentID)!
                }else {
                    ref = docRef.document(event.eventId)
                }
                event.user_id = (Auth.auth().currentUser?.uid)!
                newData = event
            }
            if data is Contact {
                var contact  = data as! Contact
                if contact.contact_id == "" {
                    ref = docRef.document()
                    contact.contact_id = (ref?.documentID)!
                }else {
                    ref = docRef.document(contact.contact_id)
                }
                contact.user_id = (Auth.auth().currentUser?.uid)!
                newData = contact
            }
            LocalNotificationManager.sharedInstance.setAlarmForDocument(data: newData!)
            ref?.setData((newData?.dictionary)!, completion: {
                err in
                if let err = err {
                    onFailure("\(err)")
                    print("Error writing document: \(err)")
                } else {
                    onSuccess()
                    print("Document successfully written!")
                }
            })
        }
    }
    
    
    
    
    func deleteEntity(id:String, target: TargetFType,onSuccess: @escaping () -> (), onFailure: @escaping (String) -> ()) {
        db.collection(target.name).document(id).delete() { err in
            if let err = err {
                onFailure("\(err)")
                
                print("Error removing document: \(err)")
            } else {
                onSuccess()
                print("Document successfully removed!")
            }
        }
    }
    
    
}
