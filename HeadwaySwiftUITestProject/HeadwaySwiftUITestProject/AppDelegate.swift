//
//  AppDelegate.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 12.06.2022.
//

import Foundation
import SwiftUI
import Firebase

@main
struct SwiftUIDelegateApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var favorite = FavoritesViewModel()
    
    var body: some Scene {
        WindowGroup {
            WelcomeView()
//            MainTabView().environmentObject(favorite)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
    
    
}

