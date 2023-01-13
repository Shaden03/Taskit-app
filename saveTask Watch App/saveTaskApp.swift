//
//  saveTaskApp.swift
//  saveTask Watch App
//
//  Created by duaa mohammed on 11/01/2023.
//

import SwiftUI

@main
struct saveTask_Watch_AppApp: App {
    var body: some Scene {
     
        WindowGroup {
            let _ = UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                     let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path)
            ContentView()
        }
    }
}
