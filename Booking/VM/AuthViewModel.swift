//
//  AuthViewModel.swift
//  Booking
//
//  Created by Zinab Zooba on 30/04/2026.
//
import SwiftUI
import Observation
import FirebaseAuth
/// الـ ViewModel المسؤول عن إدارة عمليات المصادقة (تسجيل الدخول وإنشاء الحساب).
/// يقوم بالربط بين الواجهات (Views) وخدمة المصادقة (AuthService).
@Observable class AuthViewModel {
    
    // MARK: - Properties
    var email = ""
    var password = ""
    
    /// تأكيد كلمة المرور للمطابقة.
    var confirmPassword = ""
    var isLoading = false
    //    /// الاسم الذي سيظهر في الملف الشخصي.
    //    var name = ""
    private let userService = UserService() //to make sure that user add to virebase only when it complete all fields
    /// الحالة الحالية للخطأ، إذا وجد.
    var activeError: AuthError?
    var userSession: UserSession?
    static let guestEmail = "Guest@Guest.com"
    private let authService = AuthService()
    // MARK: - Auth Methods
    
    /// يقوم بإنشاء حساب جديد للمستخدم بعد التحقق من صحة المدخلات.
    
    func signUp(UserName: String) async {
        let trimmedEmail =  email.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword =  password.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedConfirmPassword =  confirmPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedEmail.isEmpty, !trimmedPassword.isEmpty,  !trimmedConfirmPassword.isEmpty
        else{
            self.activeError = .emptyField
            return
            
        }
        
        guard isPasswordStrong(trimmedPassword)
        else
        {
            self.activeError = .invalidPassword
            return
        }
        guard  isValidEmail(trimmedEmail)
                
        else
        {
            self.activeError = .invalidEmail
            return
        }
        guard  trimmedPassword == trimmedConfirmPassword
        else{
            self.activeError = .passwordsDontMatch
            return
        }
        do {
            isLoading = true
            
            let session = try await authService.signUp(email: trimmedEmail, password: trimmedPassword)            // تحديث حالة الجلسة بالبيانات القادمة من الـ Service
            let newUser = User(id: session.uid, name: UserName, email: trimmedEmail)
            try await userService.saveUserData(user: newUser)
            self.userSession = session
            
            print("تم التسجيل بنجاح في Auth")
        } catch {
            print("خطأ في التسجيل: \(error.localizedDescription)")
            if let user = Auth.auth().currentUser  {
                try? await user.delete()
                print("User signed in")

            }
            activeError = mapError(error)

            // تأكدي من تحديث activeError هنا لعرضه في الواجهة
        }
        isLoading = false
        
    }
    /// يقوم بتسجيل دخول المستخدم.
    func signIn() async {
        
        let trimmedEmail =  email.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword =  password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        
        guard !trimmedEmail.isEmpty, !trimmedPassword.isEmpty else {
            self.activeError = .emptyField
            return
        }
        isLoading = true
        
        do {
            // 2. محاولة تسجيل الدخول
            let result = try await authService.signIn(email: trimmedEmail, password: trimmedPassword)
            self.userSession = UserSession(uid: result.user.uid , email: result.user.email!)
            print("تم تسجيل الدخول بنجاح!")
        } catch {
            // 3. هنا الخطوة الأهم: إيصال الخطأ للواجهة
            print("خطأ في تسجيل الدخول: \(error.localizedDescription)")
            // يمكنكِ لاحقاً إضافة **note**: enum خاص لأخطاء Firebase
            // مؤقتاً، يمكننا التعامل مع الخطأ
                activeError = mapError(error)
        }
        isLoading = false
    }
    
    func continueAsGuest() async {
        do {
            activeError = nil
            isLoading = true
            let result = try await authService.signInAsGuest()
            print("أهلاً بك يا ضيف! الـ UID الخاص بك: \(result.user.uid)")
            // هنا يمكنكِ توجيه التطبيق إلى الشاشة الرئيسية
            self.userSession = UserSession(uid:result.user.uid, email: AuthViewModel.guestEmail)
        } catch {
            print("فشل الدخول كضيف: \(error.localizedDescription)")
                activeError = mapError(error)
        }
        isLoading = false
    }
    
    func signOut() {
        do {
            try authService.signOut()
            userSession = nil
        }
        catch {
            print("خطأ في تسجيل الخروج:\(error.localizedDescription)")
        }
    }
    
    func resetFields(){
        email = ""
        password = ""
        confirmPassword = ""
        activeError = nil
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
        case userNotFound
        case failedToRegister
        case connectionFailed
        case emailAlreadyInUse
        case genericError
        case guestSignInFailed
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
            case .userNotFound:
                return "لم يتم العثور على المستخدم"
            case .failedToRegister:
                return "فشل التسجيل"
            case .connectionFailed:
                return "فشل الاتصال بالسيرفر"
            case .emailAlreadyInUse:
                return "البريد الإلكتروني مسجل بالفعل"
            case .genericError:
                return "حدث خطأ ما"
            case .guestSignInFailed:
                return "فشل تسجيل الدخول كضيف"
            }
            
            
            
        }
        
    }
    private func mapError(_ error: Error) -> AuthError {
        let nsError = error as NSError

        guard let errorCode = AuthErrorCode(rawValue: nsError.code) else {
            return .genericError
        }

        switch errorCode {
        case .wrongPassword:
            return .invalidPassword

        case .userNotFound:
            return .userNotFound

        case .emailAlreadyInUse:
            return .emailAlreadyInUse

        case .networkError:
            return .connectionFailed

        default:
            return .genericError
        }
    }

}
