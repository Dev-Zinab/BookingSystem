//
//  DayView.swift
//  Booking
//
//  Created by Zinab Zooba on 08/08/2026.
//
import SwiftUI

struct DayView: View {
    let date: Date
    @Binding var selectedDate: Date
    
    // فحص ما إذا كان هذا اليوم هو المحدد حالياً
    private var isSelected: Bool {
        selectedDate.isInSameDayAs(date)
    }

    var body: some View {
        VStack(spacing: 6) {
            // اسم اليوم (مثل Mon / الإثنين)
            Text(dayName(from: date))
                .font(.caption)
                .bold()
                .foregroundColor(isSelected ? .orange : .secondary)

            // دائرة رقم اليوم
            Text("\(dayNumber(from: date))")
                .font(.headline)
                .foregroundColor(isSelected ? .white : .primary)
                .frame(width: 44, height: 44)
                .background(isSelected ? Color.orange : Color(.systemGray6))
                .clipShape(Circle())
        }
        .onTapGesture {
            withAnimation(.spring(response: 0.3)) {
                selectedDate = date
            }
        }
    }

    // تجلب اسم اليوم باختصار بدقة عالية ودون استهلاك للذاكرة
    private func dayName(from date: Date) -> String {
        date.formatted(.dateTime.weekday(.abbreviated))
    }

    private func dayNumber(from date: Date) -> String {
        "\(Calendar.current.component(.day, from: date))"
    }
}
