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
    @State private var authViewModel: AuthViewModel
    @State private var userViewModel: UserViewModel
    /// الـ Session manager لتتبع حالة تسجيل الدخول
    @State private var session: SessionManager
    
    init() {
        // 1. تشغيل الفايربيز أول شيء على الإطلاق قبل بناء أي متغير
        FirebaseApp.configure()
        
        // 2. الآن نقوم بتهيئة الـ SessionManager بأمان بعد أن أصبح الفايربيز جاهزاً
        _session = State(initialValue: SessionManager())
        _authViewModel = State(initialValue: AuthViewModel())
                _userViewModel = State(initialValue: UserViewModel())
    }
    
    var body: some Scene {
        WindowGroup {
            // تحديد الـ Root View بناءً على حالة المستخدم
            if session.isAuthenticated {
                MainTabView()

            } else {
                SignInV()

            }
        }
        .environment(authViewModel)
        .environment(userViewModel)
    }
}
