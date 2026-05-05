//
//  BookingApp.swift
//  Booking
//
//  Created by Zinab Zooba on 10/03/2026.
//


import SwiftUI
import FirebaseCore

/// The application delegate responsible for Firebase configuration.
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
    
    /// The session manager tracking the user's authentication state.
    @State private var session = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            // Determine the root view based on the user's current authentication status.
            if session.isAuthenticated {
                ContentView()
            } else {
                SignInV()
            }
        }
    }
}
