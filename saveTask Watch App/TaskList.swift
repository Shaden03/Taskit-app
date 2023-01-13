//
//  TaskList.swift
//  saveTask Watch App
//
//  Created by duaa mohammed on 11/01/2023.
//

import SwiftUI
import RealmSwift
import UserNotifications

struct TaskList: View {
    @ObservedResults(AddTask.self) var addTasks
    @EnvironmentObject var realmManager: RealmManager

    
    let realm = try! Realm()

    var body: some View {
        VStack{
            HStack(spacing: 45 ){
                Text("MyTask")
                    .font(.title2)
                    .fontWeight(.bold)
                NavigationLink(destination: Home() .environmentObject(realmManager), label: {Image(systemName:"plus.circle")
                        .resizable()
                    .frame(width: 30,height: 30).foregroundColor(Color.white)})
            }.buttonStyle(.borderless)
            
            if addTasks.isEmpty{
                Text ("No")
            }
            List{
                ScrollView(.vertical , showsIndicators: true){
                    ForEach(realmManager.tasks , id: \.id){Tasks in
                        VStack{
                            
                            ZStack{
                                
                                
                                
                                
                                
                                
                                HStack{
                                    
                                    
                                    // dot
                                    check(){
                                        isChecked in
                                        if isChecked {
                                            realmManager.deleteTask(id: Tasks.id)
                                            
                                            
                                        }
                                        
                                    }.foregroundColor(Color.white)
                                    
                                    
                                    ZStack{
                                        
                                        POP()
                                            .frame(width: 130,height: 50)
                                            .padding(.trailing,10).padding(.leading,10)
                                            .foregroundColor(Color("Color1"))
                                        Text(Tasks.task) .frame(width: 110,height: 50)
                                    }
                                }
                            }
                            
                            Divider()
                            
                        }.padding()
                        //                        Text(Tasks.task)
                        
                        
                    }
                }.listRowBackground(Color.clear)
            }.scrollContentBackground(.hidden)
            
        }
//        }.onAppear{
//            requestPermission()
//        }
        
    }
    func requestPermission() {
        let notficationCenter = UNUserNotificationCenter.current()
        notficationCenter.getNotificationSettings{
            settings in
            switch settings.authorizationStatus{
            case .authorized : self.dispatchNotification()
            case .denied : return
            case .notDetermined : notficationCenter.requestAuthorization(options: [.alert , .sound]){
                didallow , error in
                if didallow {
                    self.dispatchNotification()
                }
            }
            default : return
            
            }
        }
        
    }
    func dispatchNotification (){
       let finished =  NSLocalizedString( "Finshed" , comment: "")
        let unfinished =  NSLocalizedString( "UnFinshed" , comment: "")
        let reminder = NSLocalizedString( "Reminder" , comment: "")
        let identfier = "Remineder"
        let title = reminder
        let body = realmManager.tasks.isEmpty ? finished: unfinished
        let hour = 16
        let minute = 36
        let isDayliy = true
        
        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        let calender = Calendar.current
        var dateComponents = DateComponents(calendar: calender , timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDayliy)
        let request = UNNotificationRequest (identifier: identfier, content: content, trigger: trigger)
        notificationCenter.removeAllPendingNotificationRequests()
        notificationCenter.add(request)
     
    }
}

struct TaskList_Previews: PreviewProvider {
    static var previews: some View {
        TaskList().environmentObject(RealmManager())
    }
}
