//
//  Untitled.swift
//  Booking
//
//  Created by Zinab Zooba on 03/06/2026.
//
import SwiftUI

struct LoginView: View {
    var body: some View {
        // 1. ZStack: نستخدمه كحاوية رئيسية لتغطية الخلفية بالكامل
        ZStack {
            // خلفية الشاشة (تغطية كاملة)
            Color.blue.opacity(0.1)
                .ignoresSafeArea()
            
            // 2. VStack: الحاوية الأساسية لترتيب العناصر عمودياً
            VStack(spacing: 20) {
                Text("تسجيل الدخول")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                // حقل اسم المستخدم
                TextField("اسم المستخدم", text: .constant(""))
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                
                // 3. HStack: نستخدمه لترتيب الأيقونة مع النص (أفقياً)
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.gray)
                    SecureField("كلمة المرور", text: .constant(""))
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                
                Button("دخول") {
                    print("تم الضغط")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
