//
//  UserService.swift
//  Booking
//
//  Created by Zinab Zooba on 07/05/2026.
//
///Create (saveUserData)
//
///Read (fetchUserData)
//
///Update (updateUserData)
//
///Delete (deleteUserData)
import FirebaseFirestore

struct UserService {
    
    func saveUserData(user: User) async throws {
        // هنا نبدأ "الرحلة" لإرسال البيانات
        // 1. الوصول إلى قاعدة البيانات
        let db = Firestore.firestore()

        // 2. اختيار المجموعة (users)
//        Firestore.collection(path: "users")
        // 3. تحديد المستند الخاص بهذا المستخدم (عبر الـ id)
//        Firestore.collection(path: "users").document(path: user.id).setData(from: user)

        // 4. حفظ البيانات (setData)
//        Firestore.setData(from: user)
        try  db.collection("users").document(user.id).setData(from: user)

    }
    func fetchUserData(uid: String) async throws -> User {
        let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    func updateUserData(uid: String, dataToUpdate: [String: Any]) async throws {
        let db = Firestore.firestore()
        
        // نستخدم updateData لتعديل حقول محددة فقط دون المساس بباقي المستند
        try await db.collection("users").document(uid).updateData(dataToUpdate)
    }
    
    func deleteUserData(uid: String) async throws {
        let db = Firestore.firestore()
        try await db.collection("users").document(uid).delete()
    }
}
