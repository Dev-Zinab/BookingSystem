//
//  BookingSuccessView.swift
//  Booking
//
//  Created by Zinab Zooba on 16/09/2026.
//

import SwiftUI

struct BookingSuccessView: View {
    @Binding var path: NavigationPath
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
            
            Text("Booking Successful")
                .font(.headline)
            
            Text("رقم الحجز: #BK-\(Int.random(in: 1000..<1000000))")
                .foregroundColor(.secondary)
            
            Spacer()
            
            Button(action: {
                var transaction = Transaction()
                transaction.disablesAnimations = true
                withTransaction(transaction) {
                    path = NavigationPath()
                }
                dismiss()
            }) {
                Text("Done")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    BookingSuccessView(path: .constant(NavigationPath()))
}
