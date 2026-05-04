//
//  SinUpV.swift
//  Booking
//
//  Created by Zinab Zooba on 29/04/2026.
//

import SwiftUI

struct SignUpV: View {
    @Bindable var viewModel = AuthViewModel()
    var body: some View {
        NavigationStack{
            
            
            ZStack{
                Color.yellow.edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    Text("Sign Up")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .padding(.bottom, 80)
                    
                    
                    TextField("Email", text: $viewModel.email)
                        .frame(width: 300, height: 50)
                        .padding()
                        .background(Color.white.opacity(0.40))
                        .cornerRadius(10)
                    TextField("Name", text: $viewModel.name)
                        .frame(width: 300, height: 50)
                        .padding()
                        .background(Color.white.opacity(0.40))
                        .cornerRadius(10)
                    
                    SecureField("Password", text: $viewModel.password)
                        .frame(width: 300, height: 50)
                        .padding()
                        .background(Color.white.opacity(0.40))
                        .cornerRadius(10)
                    
                    SecureField("Confirm Password", text: $viewModel.confirmPassword)
                        .frame(width: 300, height: 50)
                        .padding()
                        .background(Color.white.opacity(0.40))
                        .cornerRadius(10)
                    if let error = viewModel.activeError {
                        Text(error.errorMessage)
                            .foregroundColor(.red)
                    }
                    
                    Button(action: {

                        Task {
                                await viewModel.signUp()
                            }


                    }) {
                        Text("Sign Up")
                        
                        
                    }.buttonStyle(BorderedButtonStyle())
                    
                        .foregroundColor(.blue)
                        .background(.white)
                        .cornerRadius(10)
                        .padding()
                    
                    HStack{
                        
                        
                        Text ("Already have an account?")
                        NavigationLink(  "Sign in"){
                            SignInV()
                        }
                    }
                    HStack {
                        Text("Or continue as")
                        Button("Guest") {
                            Task{
                                await viewModel.continueAsGuest()
                            }                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    SignUpV()
}
