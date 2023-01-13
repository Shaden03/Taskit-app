//
//  ContentView.swift
//  saveTask Watch App
//
//  Created by duaa mohammed on 11/01/2023.
//

import SwiftUI
import RealmSwift
import UserNotifications

struct ContentView: View {
    @AppStorage("isFirst") var isFirst = true
    struct Page {
        let image :String
        let Subtitle:String
        let title : String
        
    }

    var pages = [Page(image:"clock" , Subtitle: NSLocalizedString( "Subtitle1" , comment: "") ,title : NSLocalizedString("Title1", comment: "") ),
                 Page(image:"calender" , Subtitle: NSLocalizedString( "SubTitle2" , comment: "") ,title : NSLocalizedString( "Title2" , comment: "") ),
                 Page(image:"logo" , Subtitle: " " ,title : NSLocalizedString( "Title3" , comment: "") )]
    @State var stepCount = 0
    @StateObject var realmManager = RealmManager()
   

    var body: some View {
        
        
        NavigationView{
            if isFirst {
                TabView(selection: $stepCount){
                    ForEach(0..<pages.count ,id: \.self) { page in
                        VStack(alignment: .leading) {
                            Image(pages[page].image)
                                .imageScale(.large).padding().padding(.top,18)
                                .foregroundColor(.accentColor)
                            Text(pages[page].title).font(.system(size: 15,design: .rounded))
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading).fixedSize(horizontal: false, vertical: true)
                            Text(pages[page].Subtitle).font(.system(size: 12,design: .rounded))
                                .fontWeight(.regular).fixedSize(horizontal: false, vertical: true).frame(maxWidth: .infinity, alignment: .leading)
                            if stepCount >= pages.count-1 {
                                
                                NavigationLink(destination:TaskList() .environmentObject(realmManager).navigationBarBackButtonHidden(true)) {
                                    
                                    Text( "Start" ).font(.system(size:12 ))
                                }.simultaneousGesture(TapGesture().onEnded{
                                    
                                    stepCount += 1
                                    isFirst = false
                                }).background(Color("Color2")).clipShape(Capsule()).cornerRadius(2).frame(width: 90).padding(.bottom,4).padding(.leading , 5)
                            } // end of if
                            else{
                                Button(action: {
                                    if stepCount < pages.count-1 {
                                        stepCount += 1
                                    }
                            
                                }){
                                    Text( "Next" ).font(.system(size:12 ))
                                }.frame(height:40 ).background(Color("Color2")).clipShape(Capsule()).cornerRadius(2).frame(width:90).padding(.bottom,10).padding(.leading , 2)
                            }
                            
                        }                }
                    
                    
                    
                }
            }else
            {
                TaskList().environmentObject(realmManager)
            }
            //        TaskList()
        }}
 
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
