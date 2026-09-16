//
//  Home View.swift
//  Booking
//
//  Created by Zinab Zooba on 08/07/2026.
//

import SwiftUI


struct HomeView: View {
    @Environment(AuthViewModel.self) private var authViewModel
    @Environment(UserViewModel.self) private var userViewModel
    var body: some View {
        @Bindable var authVM = authViewModel
        @Bindable var userVM = userViewModel
        
        
        ScrollView{
        
            LazyVStack (alignment:.trailing, spacing:16) {
                
                HStack{
                    if let session = authViewModel.userSession, session.email == AuthViewModel.guestEmail {
                        Text ("Hello, Guest")
                            .font(.headline)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                        
                    }
                    else {
                        if userViewModel.isLoading {
                            ProgressView()
                        }
                        else if userViewModel.name.isEmpty
                        {
                            Text ("اهلًا، زينب")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                            
                        }
                        else{
                            Text("Hello,\(userViewModel.name)")
                                .font(.headline)
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                        }
                    }
                    Image(systemName: "person.circle")
                        .imageScale(.large)
                        .foregroundStyle(.tint)

                    
                }
                    Text(" الغرف المتاحة:")
                        .font(.title)
                        .bold()
                        .padding(.bottom, -8)
                ForEach (Room.sampleData) { room in
               NavigationLink(destination:
                                RoomDetailView(room: room))
                    {
                   RoomCard(room: room)
                    }
               .buttonStyle(PlainButtonStyle())
                    
                        }
            } .padding(.horizontal)

                
                
//                    Button ("Sign Out")
//                    {
//                        authViewModel.signOut()
//                        authViewModel.resetFields()
//                        userViewModel.resetFields()
//                        
//                        
//                    }

                
                
                
                
                
                
            }
        }
        
         
    }


#Preview {
    // 1. ننشئ نسخ افتراضية خاصة بالـ Preview فقط لكي يقرأ منها البيانات
    let previewAuthVM = AuthViewModel()
    let previewUserVM = UserViewModel()
    
    // يمكنكِ حتى وضع اسم تجريبي ليظهر في الـ Preview فوراً وتتأكدي أنه يعمل
    previewUserVM.name = "زينب"
    
    return HomeView()
        .environment(previewAuthVM)
        .environment(previewUserVM)
}
