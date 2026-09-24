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
    // 1. تعريف المسار التفاعلي في الشاشة الرئيسية
    @Binding  var path : NavigationPath
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
                    NavigationLink(value: room)
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

                
                
                
                
                
                
            }            .navigationDestination(for: Room.self) { room in
                RoomDetailView(room: room, path: $path)
            }

        }
        
         
    }


#Preview {
    let previewAuthVM = AuthViewModel()
    
    // نجهز الكائن ونعدل خصائصه داخل closure مغلقة تُرجع الكائن جاهزاً
    let previewUserVM = {
        let vm = UserViewModel()
        vm.name = "زينب"
        return vm
    }()
    
    HomeView(path: .constant(NavigationPath()))
        .environment(previewAuthVM)
        .environment(previewUserVM)
}
