//
//  ContentView.swift
//  Booking
//
//  Created by Zinab Zooba on 10/03/2026.
//

import SwiftUI

struct ContentView: View {
    @Environment(AuthViewModel.self) private var authViewModel
    @Environment(UserViewModel.self) private var userViewModel
    var body: some View {
        @Bindable var authVM = authViewModel
        @Bindable var userVM = userViewModel
        
        VStack {
           
            
            
            
            
            
            
            
        }
        .padding()
    }
}

#Preview {
    // 1. ننشئ نسخ افتراضية خاصة بالـ Preview فقط لكي يقرأ منها البيانات
    let previewAuthVM = AuthViewModel()
    let previewUserVM = UserViewModel()
    
    // يمكنكِ حتى وضع اسم تجريبي ليظهر في الـ Preview فوراً وتتأكدي أنه يعمل
    previewUserVM.name = "زينب"
    
    return ContentView()
        .environment(previewAuthVM)
        .environment(previewUserVM)
}
