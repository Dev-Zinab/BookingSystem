//
//  SignInV.swift
//  Booking
//
//  Created by Zinab Zooba on 29/04/2026.
//

import SwiftUI

struct SignInV: View {
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

                    
                    TextField("Email", text: .constant(""))
                        .frame(width: 300, height: 50)
                        .padding()
                        .background(Color.white.opacity(0.40))
                        .cornerRadius(10)

                    TextField("Password", text: .constant(""))
                        .frame(width: 300, height: 50)
                        .padding()
                        .background(Color.white.opacity(0.40))
                        .cornerRadius(10)

                    Button(action: {}) {
                        Text("Sign in")

                           
                    }.buttonStyle(BorderedButtonStyle())
                    
                        .foregroundColor(.blue)
                        .background(.white)
                        .cornerRadius(10)
                        .padding()
                    
                    HStack{
                        
                        
                        Text ("Don't have an account?")
                        NavigationLink("Sign up"){
                            SignUpV( )
                        }
                    }
                    HStack{
                        Text("Or Continue as")
                        Button (" Guest"){
                            
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
