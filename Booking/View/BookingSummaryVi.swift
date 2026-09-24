//
//  BookingSummaryVi.swift
//  Booking
//
//  Created by Zinab Zooba on 18/08/2026.
//

import SwiftUI
struct BookingSummaryView: View {
    let room: Room
    let checkInDate: Date
    let checkOutDate: Date
    let numberOfNight: Int
    var totalPrice: Double {
        Double(numberOfNight) * room.price
    }//    var viewModel: BookingViewModel
    @State private var showPaymentView = false
    @Binding var path : NavigationPath
    var body: some View {
        VStack{
            ScrollView{
                Image(systemName: "checkmark.seal.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.green)
                    .padding()
                Text("تآكيد الحجز")
                    .font(.headline)
                    .padding()
                VStack(alignment: .leading, spacing: 12) {
                    Text("ملخص الحجز:")
                        .font(.headline)
                        .padding(.bottom, 4)
                    
                    HStack {
                        Text("• الغرفة:")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(room.roomName)
                            .bold()
                    }
                    
                    HStack {
                        Text("• التواريخ:")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(checkInDate.formatted(date: .abbreviated, time: .omitted)) - \(checkOutDate.formatted(date: .abbreviated, time: .omitted))")
                            .bold()
                    }
                    
                    HStack {
                        Text("• عدد الليالي:")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text("\(numberOfNight)")
                            .bold()
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("• السعر الإجمالي:")
                            .font(.headline)
                        Spacer()
                        Text("\(totalPrice.formatted(.number.precision(.fractionLength(2)))) ر.س")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(16)
                .padding(.horizontal)   .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                
                Button(action: {
                    
                    showPaymentView = true                })
                {
                    Text("دفع وحجز الآن")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green) // لون مخصص للدفع
                        .foregroundColor(.white)
                    .cornerRadius(12)                }
                .padding(.horizontal)
                .padding(.top, 10)
                .sheet(isPresented: $showPaymentView)
                {                                PaymentView(path: $path, room: room, numberOfNight: numberOfNight)
                }
                
            }
            .environment(\.layoutDirection, .rightToLeft) // إجبار الاتجاه من اليمين لليسار
        }    }
}
#Preview {
    BookingSummaryView(
        // 1. إنشاء كائن Room تجريبي (طابقي المتغيرات مع الـ Struct الخاص بك)
        room: Room.sampleData[0],
        
        // 2. تاريخ اليوم
        checkInDate: Date(), 
        
        // 3. تاريخ خروج بعد 4 أيام
        checkOutDate: Calendar.current.date(byAdding: .day, value: 4, to: Date())!,
        
        // 4. عدد الليالي
        numberOfNight: 4,
        path: .constant(NavigationPath())
    )
}
