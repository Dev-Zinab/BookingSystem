//
//  SignInV.swift
//  Booking
//
//  Created by Zinab Zooba on 29/04/2026.
//

import SwiftUI

struct SignInV: View {
    @Environment(AuthViewModel.self) private var authViewModel
    @Environment(UserViewModel.self) private var userViewModel
    var body: some View {
        @Bindable var authVM = authViewModel
        @Bindable var userVM = userViewModel

        NavigationStack{
            
            ZStack{
                Color.yellow.edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Text("Sign in")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.bottom, 80)
                    
                    HStack{
                        Image(systemName: "envelope")
                            .foregroundColor(.gray)
                            .font(.title)

                        TextField("Email", text: $authVM.email)
                    }
                    .frame(width: 300, height: 50)
                    .padding()
                    .background(Color.white.opacity(0.40))
                    .cornerRadius(10)

                    HStack{
                        Image(systemName: "lock")
                            .foregroundColor(.gray)
                            .font(.title)
                        
                        SecureField("Password",text: $authVM.password)
                        
                    }
                    .frame(width: 300, height: 50)
                    .padding()
                    .background(Color.white.opacity(0.40))
                    .cornerRadius(10)

                    Button(action: {
                        
                        Task {
                            await authVM.signIn()
                            if let session = authVM.userSession  {
                                await  userVM.fetchCurrentUser((session.uid))
                            }
                        }
                        
                    }) {
                        if authVM.isLoading {
                            ProgressView()
                        }
                        else {
                            Text("Sign in")
                            
                        }
                    }.buttonStyle(BorderedButtonStyle())
                    
                        .foregroundColor(.blue)
                        .background(.white)
                        .cornerRadius(10)
                        .padding()
                        .disabled(authVM.isLoading)
                    

                    HStack {
                        // If the user doesn't have an account, direct them to sign up
                        Text("Don't have an account?")
                        NavigationLink("Sign up") {
                            // 1. Navigate to Create Account screen
                            SignUpV()
                        }
                    }
                    HStack {
                        Text("Or Continue as")
                        Button(" Guest") {
                            // 2. Continue as a guest (no account needed)
                            Task {
                                await authVM.continueAsGuest()
                            }
                        }
                    }
                    
                }
            }
        }.onAppear(){
            authViewModel.resetFields()
            userViewModel.resetFields()
        }
        
    }
    
}

#Preview {
    SignInV()
}
