//
//  SocialMediaApp.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 17/10/2022.
//

import SwiftUI
import FirebaseCore



@main
struct SocialMediaApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    @StateObject private var vm_exploreView = VM_ExploreView()
    @StateObject private var firebaseManager = FirebaseManager()
    
    @AppStorage("loggedIn") private var loggedIn: Bool = false
    let dev = DeveloperPreview.instance
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                if loggedIn{
                    ContentView()
                        .navigationBarHidden(true)
                        .environmentObject(vm_exploreView)
                }else{
                    RegisterUser()
                        .navigationBarHidden(true)
                        .environmentObject(vm_exploreView)
                }
            }
            .onAppear{
                firebaseManager.fetchData()
            }
        }
    }
}


