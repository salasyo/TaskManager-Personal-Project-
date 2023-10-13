//
//  TaskManagerApp.swift
//  TaskManager
//
//  Created by o.o on 6/11/23.
//

import SwiftUI
import Firebase

@main
struct TaskManagerApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var showLaunchView: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    RootView()
                }
                .modelContainer(for: [Activity.self, Expense.self, Category.self])
                
                if showLaunchView {
                    LaunchView(showLaunchView: $showLaunchView)
                        .transition(.move(edge: .leading))
                        .zIndex(2.0)
                        .onAppear {
                         DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                          withAnimation {
                             showLaunchView = false
                             }
                           }
                     }
                }
            }
        }
        
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
}
