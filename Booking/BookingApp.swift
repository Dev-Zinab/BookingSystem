//
//  BookingApp.swift
//  Booking
//
//  Created by Zinab Zooba on 10/03/2026.
//


import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        FirebaseApp.configure()
        return true
    }
}

@main
struct BookingApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State private var session = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            if session .isAuthenticated {
                ContentView()

            }
            else {
                SignInV()
            }
        }
    }
}
