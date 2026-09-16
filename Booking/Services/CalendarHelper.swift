//
//  CalendarHelper.swift
//  Booking
//
//  Created by Zinab Zooba on 10/08/2026.
//

import SwiftUI
import SwiftData

struct CalendarHelper {
    static let calendar = Calendar.current

    static  func dayNumber(from date :Date)-> String{
//        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        return "\(day)"
    }
    static func startOfMonth (date:Date) -> Date? {
        let calendar = Calendar.current
        return calendar.date(from: calendar.dateComponents([.year, .month], from: date))
        
        
    }
    static  func monthNumber(from date :Date)-> Int{
//        let calendar = Calendar.current
        //لمن اجيب الشهر والسنة لهذا التاريخ المدخل فتلقائيا يعطيني النظام اليوم الاول من الشهر
        if let startOfMonth = startOfMonth(date: date)
        {
            let range = calendar.range(of: .day, in: .month, for:startOfMonth)
            return range?.count ?? 0
            
            
        }
        return 0
    }
    static func daysInMonth(from date: Date) -> [Date?] {
        guard let startOfMonth = startOfMonth(date: date),
              let range = calendar.range(of: .day, in: .month, for: startOfMonth)
        else {
            return []
        }

        // تحديد يوم الأسبوع لأول يوم في الشهر
        let firstWeekday = calendar.component(.weekday, from: startOfMonth)

        // إضافة الأيام الفارغة قبل بداية الشهر
        var days: [Date?] = Array(repeating: nil, count: firstWeekday - 1)

        // إضافة الأيام الفعلية للشهر
        days.append(contentsOf: range.compactMap { day -> Date? in
            calendar.date(byAdding: .day, value: day - 1, to: startOfMonth)
        })

        return days
    }

    static func left(from date: Date) -> Date? {
//        let calendar = Calendar.current

    // ضبط التاريخ على بداية الشهر الحالي
        guard let startOfMonth = startOfMonth(date: date)
        else {
        return nil
    }
    // طرح شهر واحد
    return calendar.date(byAdding: .month, value: -1, to: startOfMonth)
}

    static func right (from date: Date) -> Date? {
//        let calendar = Calendar.current

    // ضبط التاريخ على بداية الشهر الحالي
        guard let startOfMonth = startOfMonth(date: date)
        else {
        return nil
    }
    // إضافة شهر واحد
    return calendar.date(byAdding: .month, value: 1, to: startOfMonth)
}

    static func formattedDate(_ date:Date)->String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from:date)
    }
    
}

