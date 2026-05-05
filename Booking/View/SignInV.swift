//
//  SignInV.swift
//  Booking
//
//  Created by Zinab Zooba on 29/04/2026.
//

import SwiftUI

struct SignInV: View {
    @Bindable var viewModel = AuthViewModel()
    var body: some View {
        
        NavigationStack{
            
            ZStack{
                Color.yellow.edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Text("Sign in")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.bottom, 80)
                    
                    
                    TextField("Email", text: $viewModel.email)
                        .frame(width: 300, height: 50)
                        .padding()
                        .background(Color.white.opacity(0.40))
                        .cornerRadius(10)
                    
                    SecureField("Password",text: $viewModel.password)
                        .frame(width: 300, height: 50)
                        .padding()
                        .background(Color.white.opacity(0.40))
                        .cornerRadius(10)
                    
                    Button(action: {
                        
                        Task {
                            await viewModel.signIn()
                        }
                        
                    }) {
                        Text("Sign in")
                        
                        
                    }.buttonStyle(BorderedButtonStyle())
                    
                        .foregroundColor(.blue)
                        .background(.white)
                        .cornerRadius(10)
                        .padding()
                    

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
                                await viewModel.continueAsGuest()
                            }
                        }
                    }
                    
                }
            }
        }
        
    }
    
}

#Preview {
    SignInV()
}
