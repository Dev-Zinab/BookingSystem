//
//  AuthViewModel.swift
//  Booking
//
//  Created by Zinab Zooba on 30/04/2026.
//
import SwiftUI
import Observation

/// الـ ViewModel المسؤول عن إدارة عمليات المصادقة (تسجيل الدخول وإنشاء الحساب).
/// يقوم بالربط بين الواجهات (Views) وخدمة المصادقة (AuthService).
@Observable class AuthViewModel {
    
    // MARK: - Properties
    
    var email = ""
    var password = ""
    
    /// تأكيد كلمة المرور للمطابقة.
    var confirmPassword = ""
    
    /// الاسم الذي سيظهر في الملف الشخصي.
    var name = ""

    /// الحالة الحالية للخطأ، إذا وجد.
    var activeError: AuthError?
    
    private let authService = AuthService()
    
    // MARK: - Auth Methods
    
    /// يقوم بإنشاء حساب جديد للمستخدم بعد التحقق من صحة المدخلات.
    
    func signUp() async {
        guard !email.isEmpty, !password.isEmpty, !name.isEmpty, !confirmPassword.isEmpty
        else{
            self.activeError = .emptyField
            return
            
        }
        
        guard isPasswordStrong(password)
        else
        {
            self.activeError = .invalidPassword
            return
        }
        guard  isValidEmail(email)
        else
        {
            self.activeError = .invalidEmail
            return
        }
        guard  password == confirmPassword
        else{
            self.activeError = .passwordsDontMatch
            return
        }
        do {
            // استدعاء الخدمة مع تمرير البيانات التي أدخلها المستخدم
            let user = try await authService.signUp(email: email, password: password, name: name)
            print("تم التسجيل بنجاح لـ: \(user.displayName ?? name)")
        } catch {
            // هنا نلتقط أي خطأ يرجع من Firebase
            print("حدث خطأ: \(error.localizedDescription)")
        }
    }
    /// يقوم بتسجيل دخول المستخدم.
    func signIn() async {
        guard !email.isEmpty, !password.isEmpty else {
            self.activeError = .emptyField
            return
        }
        
        do {
            
            // 2. محاولة تسجيل الدخول
            
            try await authService.signIn(email: email, password: password)
            print("تم تسجيل الدخول بنجاح!")
        } catch {
            // 3. هنا الخطوة الأهم: إيصال الخطأ للواجهة
            print("خطأ في تسجيل الدخول: \(error.localizedDescription)")
            
            // يمكنكِ لاحقاً إضافة **note**: enum خاص لأخطاء Firebase
            // مؤقتاً، يمكننا التعامل مع الخطأ
            self.activeError = .invalidPassword // أو إنشاء حالة خطأ جديدة لـ SignIn
        }
    }
    
    func continueAsGuest() async {
        do {
            let result = try await authService.signInAsGuest()
            print("أهلاً بك يا ضيف! الـ UID الخاص بك: \(result.user.uid)")
            // هنا يمكنكِ توجيه التطبيق إلى الشاشة الرئيسية
        } catch {
            print("فشل الدخول كضيف: \(error.localizedDescription)")
        }
    }
    
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    /// - Returns: الدالة ترجع كلمة السر بالي تمثل الشروط (فيها حرف كبير ، حرف صغير، رقم)
    
    func isPasswordStrong( _ password:String)-> Bool{
        if password.count < 8 {
            return false
        }
        
        let hasIntiger = password.rangeOfCharacter(from: .decimalDigits) != nil
        let hasLowercase = password.rangeOfCharacter(from: .lowercaseLetters) != nil
        let hasUppercase = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        
        return hasIntiger && hasLowercase && hasUppercase
    }
    
    
    
    enum AuthError: Error,Hashable{
        case invalidEmail
        case invalidPassword
        case passwordsDontMatch
        case emptyField
        /// - Returns:  ترجع رسالة توضيحية بالخطاء  في الادخال
        
        var errorMessage: String { // لاحظي حذفنا علامة = وأضفنا النوع : String
            switch self {
            case .invalidEmail:
                return "البريد الإلكتروني غير صحيح"
            case .invalidPassword:
                return "كلمة المرور غير صحيحة"
            case .passwordsDontMatch:
                return "كلمات المرور غير متطابقة"
            case .emptyField:
                return "يجب ملئ الجميع الحقول"
            }
            
            
            
        }
    }
}
