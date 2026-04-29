//
//  SinUpV.swift
//  Booking
//
//  Created by Zinab Zooba on 29/04/2026.
//

import SwiftUI

struct SignUpV: View {
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

            
            TextField("Email", text: .constant(""))
                .frame(width: 300, height: 50)
                .padding()
                .background(Color.white.opacity(0.40))
                .cornerRadius(10)
            TextField("Name", text: .constant(""))
                .frame(width: 300, height: 50)
                .padding()
                .background(Color.white.opacity(0.40))
                .cornerRadius(10)

            TextField("Password", text: .constant(""))
                .frame(width: 300, height: 50)
                .padding()
                .background(Color.white.opacity(0.40))
                .cornerRadius(10)

            TextField("Confirm Password", text: .constant(""))
                .frame(width: 300, height: 50)
                .padding()
                .background(Color.white.opacity(0.40))
                .cornerRadius(10)

            Button(action: {}) {
                Text("Sign Up")

                   
            }.buttonStyle(BorderedButtonStyle())
            
                .foregroundColor(.blue)
                .background(.white)
                .cornerRadius(10)
                .padding()
            
            HStack{
                
                
                Text ("Already have an account?")
                NavigationLink(  "Sign in"){
                    SignInV( )
                }
            }
            Button ("Continoe as Guest"){
                
            }
            
        }
        }
        }
    
    }
}

#Preview {
    SignUpV()
}
