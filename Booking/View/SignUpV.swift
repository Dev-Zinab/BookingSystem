//
//  SinUpV.swift
//  Booking
//
//  Created by Zinab Zooba on 29/04/2026.
//



import SwiftUI
import FirebaseCore

struct SignUpV: View {
    
    @Environment(AuthViewModel.self) private var authViewModel
    @Environment(UserViewModel.self) private var userViewModel 
    
    var body: some View {
        // نستخدم Bindable لربط الحقول بالـ ViewModels
        @Bindable var authVM = authViewModel
        @Bindable var userVM = userViewModel
        
            ScrollView {
                
                VStack {
                    Text("Sign Up")
                        .font(.largeTitle)
                           .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.top, 80)
                    
                    // حقول الإدخال
                   Image(systemName: "water.waves")
                        .font(.custom("pompidou", size: 200.0))
                        .foregroundStyle(.white)
                        .padding()
                    
                    
                    
                    Group {
                        HStack{
                            Image(systemName:"mail.fill")
                            TextField("Email", text: $authVM.email)
                        }
                        HStack {
                            Image(systemName:"person.fill")
                            TextField("Name", text: $userVM.name)
                        }
                        HStack{
                            Image(systemName:"lock")
                            SecureField("Password", text: $authVM.password)
                        }
                        HStack {
                            Image(systemName:"lock.fill")
                            SecureField("Confirm Password", text: $authVM.confirmPassword)
                        }
                    }
                    .frame(width: 250, height: 20)
                    .padding()
                    .background(Color.white.opacity(0.40))
                    .cornerRadius(10)
                    
                    // عرض الأخطاء (Auth + User)
                    VStack {
                        if let authError = authVM.activeError {
                            Text(authError.errorMessage)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                        if let userError = userVM.errorMessage {
                            Text(userError)
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                    .padding(.top, 5)
                    
                    // زر التسجيل
                    Button(action: {
                        guard userVM.isInputValid else { return }
                        
                        Task {
                            await authViewModel.signUp(UserName: userVM.name)
                            
                            // هنا السر: نستخدم authViewModel مباشرة وليس النسخة الـ Bindable
                        }
                    }) {
                        if authVM.isLoading {
                            ProgressView()
                        }
                        else{
                            Text("Sign Up")
                                .frame(width: 200)
                        }}
                    .buttonStyle(BorderedButtonStyle())
                    .foregroundColor(.blue)
                    .background(.white)
                    .cornerRadius(10)
                    .padding()
                    .disabled(authVM.isLoading)
                    
                    // الروابط السفلية
                    HStack {
                        Text("Already have an account?")
                        NavigationLink("Sign in") {
                            SignInV()
                        }
                    }
                    
                    HStack {
                        Text("Or continue as")
                        Button("Guest") {
                            Task {
                                await authVM.continueAsGuest()
                            }
                        }
                    }
                }
                
            // نهاية VStack
            } // نهاية
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.teal)
            .onAppear(){
            authViewModel.resetFields()
            userViewModel.resetFields()
        }

        
    } // نهاية Body
} // نهاية Struct

#Preview {
    // 1. نضمن تهيئة الفايربيز أولاً داخل بيئة الـ Preview
    let _ = {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }()
    
    // 2. ننشئ نسخ خاصة بالـ Preview فقط
    let previewAuthVM = AuthViewModel()
    let previewUserVM = UserViewModel()
    
    // 3. نمررها للصفحة حتى يقرأها الـ @Environment بنجاح
    return SignUpV()
        .environment(previewAuthVM)
        .environment(previewUserVM)
}
