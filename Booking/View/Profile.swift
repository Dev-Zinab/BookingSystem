//
//  Untitled.swift
//  Booking
//
//  Created by Zinab Zooba on 03/06/2026.
//
import SwiftUI

struct Profile: View {
    @Environment(AuthViewModel.self) private var authViewModel
    @Environment(UserViewModel.self) private var userViewModel
    
    var body: some View {
        ZStack {
            // خلفية الشاشة (تغطية كاملة)
            Color.blue.opacity(0.1)
                .ignoresSafeArea()
            
            // 2. VStack: الحاوية الأساسية لترتيب العناصر عمودياً
            VStack(spacing: 20) {
                HStack {
                    Spacer()
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .foregroundColor(.blue)
                }
                HStack{
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 5.0){
                        
                        if let session = authViewModel.userSession, session.email == AuthViewModel.guestEmail{
                            Text("Guest")
                                .font(.title)
                                .fontWeight(.bold)
                            
                            
                        }
                        else{
                            Text(userViewModel.name)
                                .font(.title)
                                .fontWeight(.bold)
                            Text(authViewModel.email)
                                .font(.subheadline)
                                .fontWeight(.bold)
                            
                            
                        }
                    }                             .padding()
                    
                }
                Spacer()
                
                HStack{
                    Spacer()
                    
                    
                    Button(action:{                     authViewModel.signOut()
                        authViewModel.resetFields()
                        userViewModel.resetFields()
                    }, label:{
                        Label("Sign Out", systemImage:  "door.right.hand.open")
                        
                    }).buttonStyle(.bordered)
                        .tint(.red)
                }
                
                
                
                
            } .padding()
        }
    }
}
#Preview {
    let previewAuthVM = AuthViewModel()
    let previewUserVM = UserViewModel()
    previewUserVM.name = "Zinab"
    previewAuthVM.email = "zinab@gmail.com"
    return Profile()
        .environment(previewAuthVM)
        .environment(previewUserVM)
    
    
}

