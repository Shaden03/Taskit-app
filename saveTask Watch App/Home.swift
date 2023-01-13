//
//  Home.swift
//  saveTask Watch App
//
//  Created by duaa mohammed on 12/01/2023.
//

import SwiftUI
import RealmSwift
struct Home: View {
    @EnvironmentObject var realmManager: RealmManager
       @State var viewText = false
    @State var task:String = ""
    @State var currentDate:Date =  Date()
    @ObservedResults(AddTask.self) var addTasks
    var body: some View {
        NavigationView{        if viewText == false {
            VStack {
                Text("Recorde")
                    .multilineTextAlignment(.leading)
                    .padding(/*@START_MENU_TOKEN@*/.bottom, 5.0/*@END_MENU_TOKEN@*/)
                
                Button(action: talking) {
                    HStack {
                        //                    Text("Start talking")
                        Image(systemName: "mic")
                            .resizable().foregroundColor(Color("DarkBlue"))
                            .frame(width: 30.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/40.0)
                    }
                }
                .buttonStyle(YellowButton())
                
            }
        }
            else
            {
                VStack {
                    TextField("Add", text: $task)
                    NavigationLink(destination: TaskList().navigationBarBackButtonHidden(true) .environmentObject(realmManager), label: {
                    Text("Add")
                    }).simultaneousGesture(TapGesture().onEnded{
                        if task != "" {
                            realmManager.addTask(task: task)}
                    })
                    
                }
                .padding()}
        }}
    func talking() {
        WKExtension.shared().visibleInterfaceController!
            .presentTextInputController(withSuggestions: nil,
                                        allowedInputMode: .plain,
                completion: { (result) -> Void in
                task = result.self?[0] == nil ? "" : result.self![0] as! String
                if (result.self?[0] != nil){
                    viewText = true}
 
        })
    }
    
    struct YellowButton: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
    //            .padding(.vertical)
    //            .padding(.horizontal, 25.0)
                .frame(width: 90, height: 90)
                .background(Color.white)
                .foregroundColor(Color.black)
    //            .cornerRadius(10.0)
                .clipShape(Circle()).accessibilityLabel("Keybord Button").accessibilityAddTraits(.isButton).accessibilityRemoveTraits(.isButton)
 
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home().environmentObject(RealmManager())
    }
}
