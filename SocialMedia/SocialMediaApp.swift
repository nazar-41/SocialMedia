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
    
    var body: some Scene {
        WindowGroup {
//            NavigationView{
//                ContentView()
//                    .navigationBarHidden(true)
//                    .environmentObject(vm_exploreView)
//            }
            
            SignUpView()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
