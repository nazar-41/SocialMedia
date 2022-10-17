//
//  SocialMediaApp.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 17/10/2022.
//

import SwiftUI

@main
struct SocialMediaApp: App {
    @StateObject private var vm_exploreView = VM_ExploreView()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
                    .navigationBarHidden(true)
                    .environmentObject(vm_exploreView)
            }
        }
    }
}
