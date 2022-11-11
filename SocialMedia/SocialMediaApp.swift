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
    @StateObject private var globalDownload = GlobalDownload()
    
    @AppStorage("loggedIn") private var loggedIn: Bool = false
    @AppStorage("email") private var email: String = ""
    let dev = DeveloperPreview.instance
    
    var body: some Scene {
        WindowGroup {
            
            NavigationView{
                if loggedIn{
                    ContentView()
                        .navigationBarHidden(true)
                        .environmentObject(vm_exploreView)
                        .environmentObject(globalDownload)
                }else{
                    RegisterUser()
                        .navigationBarHidden(true)
                        .environmentObject(vm_exploreView)
                        .environmentObject(globalDownload)

                }
            }
             
            
//            PostCommentsSheet(post: DeveloperPreview.instance.postCardModel)
        }
    }
}


