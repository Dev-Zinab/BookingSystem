//
//  AuthViewModel.swift
//  Booking
//
//  Created by Zinab Zooba on 30/04/2026.
//
import SwiftUI
import Observation

@Observable class AuthViewModel {
    var email = ""
    var password = ""
    var name = ""
    var confirmPassword = ""
    var activeError: AuthError?
    func signUp() {
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
    }
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isPasswordStrong( _ password:String)-> Bool{
        if password.count < 8 {
            return false
        }
        
        let hasIntiger = password.rangeOfCharacter(from: .decimalDigits) != nil
        let hasLowercase = password.rangeOfCharacter(from: .lowercaseLetters) != nil
        let hasUppercase = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        
        return hasIntiger && hasLowercase && hasUppercase
    }
    
    
}

enum AuthError: Error,Hashable{
    case invalidEmail
    case invalidPassword
    case passwordsDontMatch
    case emptyField
    
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
