//
//  Calender.swift
//  Booking
//
//  Created by Zinab Zooba on 10/08/2026.
//
import SwiftUI

struct CalendarGridView: View {
    @Binding var selectedDate: Date
    let days: [Date?] // 👈 مصفوفة تقبل nil للأيام الفارغة في بداية الشهر
    
    let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        LazyVGrid(columns: columns, spacing: 14) {
            ForEach(0..<days.count, id: \.self) { index in
                if let date = days[index] {
                    // يوم فعلي
                    DayView(date: date, selectedDate: $selectedDate)
                } else {
                    // مساحة فارغة لضبط بداية أول يوم في الأسبوع
                    Color.clear
                        .frame(height: 44)
                }
            }
        }
        .padding()
    }
}
