//
//  RealmManager.swift
//  saveTask Watch App
//
//  Created by duaa mohammed on 12/01/2023.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    private(set) var localRealm: Realm?
    @Published var tasks: [AddTask] = []


    
    
    // On initialize of the class, we'll open a Realm and get the tasks saved in the Realm
    init() {
        openRealm()
        getTasks()
    }
    
    // Function to open a Realm (like a box) - needed for saving data inside of the Realm
    func openRealm() {
        do {
            // Setting the schema version
            let config = Realm.Configuration(schemaVersion: 1)
            
            // Letting Realm know we want the defaultConfiguration to be the config variable
            Realm.Configuration.defaultConfiguration = config
            
            // Trying to open a Realm and saving it into the localRealm variable
            localRealm = try Realm()
        } catch {
            print("Error opening Realm", error)
        }
    }
    func addTask(task: String) {
           if let localRealm = localRealm { // Need to unwrap optional, since localRealm is optional
               do {
                   // Trying to write to the localRealm
                   try localRealm.write {
                       // Creating a new Task
                       let newTask = AddTask(value: ["task": task])
                      
                       // Adding newTask to localRealm
                       localRealm.add(newTask)
                       
                       // Re-setting the tasks array
                       getTasks()
                       print("Added new task to Realm!", newTask)
                   }
               } catch {
                   print("Error adding task to Realm: \(error)")
               }
           }
       }
    func getTasks() {
          if let localRealm = localRealm {
              
              // Getting all objects from localRealm and sorting them by completed state
              let allTasks = localRealm.objects(AddTask.self)
              
              // Resetting the tasks array
              tasks = []
              
              // Append each task to the tasks array
              allTasks.forEach { task in
                  tasks.append(task)
              }
          }
      }
    func deleteTask(id: ObjectId) {
        if let localRealm = localRealm {
            do {
                // Find the task we want to delete by its id
                let taskToDelete = localRealm.objects(AddTask.self).filter(NSPredicate(format: "id == %@", id))
                
                // Make sure we found the task and taskToDelete array isn't empty
                guard !taskToDelete.isEmpty else { return }
                
                // Trying to write to the localRealm
                try localRealm.write {
                    
                    // Deleting the task
                    localRealm.delete(taskToDelete)
                    
                    // Re-setting the tasks array
                    getTasks()
                    print("Deleted task with id \(id)")
                }
            } catch {
                print("Error deleting task \(id) to Realm: \(error)")
            }
        }
    }
    
  
}
