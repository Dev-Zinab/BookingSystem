//
//  AuthService.swift
//  Booking
//
//  Created by Zinab Zooba on 04/05/2026.
//

import Foundation
import FirebaseAuth

// هذا القالب لا يتغير، Firebase صممته ليعمل بهذه الطريقة دائماً
struct AuthService {
    
    // تسجيل مستخدم جديد
    func signUp(email: String, password: String, name: String) async throws -> FirebaseAuth.User {
        // 1. إنشاء الحساب
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        let user = result.user
        
        // 2. تحديث الاسم (هذا هو الكود الجاهز لتحديث البيانات)
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = name
        try await changeRequest.commitChanges()
        
        return user
    }
    // تسجيل الدخول
    func signIn(email: String, password: String) async throws -> AuthDataResult {
        return try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    // تسجيل الخروج
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    // تسجيل دخول كضيف (Anonymous)
    func signInAsGuest() async throws -> AuthDataResult {
        return try await Auth.auth().signInAnonymously()
    }
    // التحقق من حالة المستخدم الحالي
    var currentUser: FirebaseAuth.User? {
        return Auth.auth().currentUser
    }
}
