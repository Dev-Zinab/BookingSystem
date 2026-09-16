//
//  CardModifier.swift
//  Booking
//
//  Created by Zinab Zooba on 05/07/2026.
//



import SwiftUI

struct CardModifier: ViewModifier {
    func body(content: Content)-> some View {
        content
            .padding()
            .frame(maxWidth: .infinity, alignment: .trailing)
            .background(Color(.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(radius: 5)

            

    }
}

 
     extension View {
         func cardStyle() -> some View {
             self.modifier(CardModifier())

         }
    }

#Preview {
    VStack{
            Text("الجناح الملكي")
            .cardStyle()
            Text("الغرفة الكلاسيكية")
            .cardStyle()
            Text("غرفة البساطة")
            .cardStyle()
            Text("الجناح اللعائلي ")
            .cardStyle()
        }
            

            }

            

    


