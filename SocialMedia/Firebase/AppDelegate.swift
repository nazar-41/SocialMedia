//
//  AppDelegate.swift
//  SocialMedia
//
//  Created by Belli's MacBook on 21/10/2022.
//


//MARK: Firebase app delegate

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
    
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      

    return true
  }
}
