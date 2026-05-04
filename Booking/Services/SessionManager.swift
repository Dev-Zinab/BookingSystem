//
//  Untitled.swift
//  Booking
//
//  Created by Zinab Zooba on 04/05/2026.
//

import Foundation
import FirebaseAuth

@Observable class SessionManager {
    var isAuthenticated: Bool = false
    
    init() {
        // التحقق فور تشغيل التطبيق هل هناك مستخدم مسجل مسبقاً؟
        self.isAuthenticated = Auth.auth().currentUser != nil
        
        // مراقبة التغيرات (إذا سجل خروج أو دخول)
        Auth.auth().addStateDidChangeListener { auth, user in
            self.isAuthenticated = user != nil
        }
    }
}
