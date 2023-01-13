//
//  AddModule.swift
//  saveTask Watch App
//
//  Created by duaa mohammed on 11/01/2023.
//

import Foundation
import RealmSwift
class AddTask: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId // This is our primary key, and each Task instance can be uniquely identified by the ID
    @Persisted var task = ""
    
}
