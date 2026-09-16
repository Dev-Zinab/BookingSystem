//
//  RoomBookingView.swift
//  Booking
//
//  Created by Zinab Zooba on 08/08/2026.
//

import SwiftUI

struct RoomBookingView: View

{

    @State private var viewModel : BookingViewModel
    
    init(room: Room) {
            _viewModel = State(initialValue: BookingViewModel(room: room))
        }

    @State private var days: [Date?] = []
//    @State private var selectedDate: Date = Date() // التاريخ المحدد للحجز
    @State private var displayedMonth: Date = Date() // الشهر المعروض حالياً في التقويم

    private let calendar = Calendar.current

    // منع العودة لأشهر سابقة عن الشهر الحالي
    private var canGoToPreviousMonth: Bool {
        calendar.compare(displayedMonth, to: Date(), toGranularity: .month) == .orderedDescending
    }
    var body: some View {
        VStack(spacing: 24) {
            
            // 1. كارت التقويم الشبكي
            VStack(spacing: 16) {
                
                // عرض الشهر والأسهم للتنقل
                HStack {
                    Text(displayedMonth.formatted(.dateTime.month().year()))
                        .font(.headline)
                        .bold()
                    
                    Spacer()
                    
                    HStack(spacing: 16) {
                        // زر الشهر السابق
                        Button(action: {
                            if canGoToPreviousMonth, let newDate = CalendarHelper.left(from: displayedMonth) {
                                displayedMonth = newDate
                                days = CalendarHelper.daysInMonth(from: newDate)
                            }
                        }) {
                            Image(systemName: "chevron.right")
                                .font(.body.weight(.bold))
                                .foregroundColor(canGoToPreviousMonth ? .primary : .gray.opacity(0.3))
                        }
                        .disabled(!canGoToPreviousMonth)

                        // زر الشهر التالي
                        Button(action: {
                            if let newDate = CalendarHelper.right(from: displayedMonth) {
                                displayedMonth = newDate
                                days = CalendarHelper.daysInMonth(from: newDate)
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.body.weight(.bold))
                                .foregroundColor(.primary)
                        }
                    }
                }
                .padding(.horizontal, 8)

                // أسماء أيام الأسبوع

                HStack {
                    ForEach(calendar.shortWeekdaySymbols, id: \.self) { dayName in
                        Text(dayName)
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity)
                    }

                }

                // شبكة الأيام
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7), spacing: 8) {
                    ForEach(0..<days.count, id: \.self) { index in
                        if let date = days[index] {
//                            let weekday = calendar.component(.weekday, from: date)
                            let isPast = calendar.startOfDay(for: date) < calendar.startOfDay(for: Date())
//                            let isWeekend = (weekday == 6 || weekday == 7) // الجمعة والسبت
                            let isAvailable = !isPast
                            let isSelected = viewModel.isSelectedEndpoint(date)
                            Text(CalendarHelper.dayNumber(from: date))
                                .font(.headline)
                                .frame(width: 40, height: 40)
                                .background(dayBackgroundColor(
                                    isEndpoint: viewModel.isSelectedEndpoint(date),
                                            inRange: viewModel.isInRange(date),
                                            isAvailable: isAvailable                                ))
                                .foregroundColor(
                                    !isAvailable ? .gray.opacity(0.3) : (isSelected ? .white : .primary)
                                )
                                .clipShape(Circle())
                                .onTapGesture {
                                    if isAvailable {
                                        viewModel.selectDate(date)                                  }
                                }
                        } else {
                            // مساحة فارغة للخلية المفرغة (nil)
                            Color.clear
                                .frame(width: 40, height: 40)
                        }
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
            )
            .padding(.horizontal)
            .onAppear {
                days = CalendarHelper.daysInMonth(from: displayedMonth)
            }

            // 2. عرض تاريخ الدخول والخروج وزر التأكيد
            VStack(spacing: 16) {
                
                // كارت عرض التواريخ المحددة
                HStack {
                    // تاريخ الدخول
                    VStack(spacing:4) {
                        Text("تاريخ الدخول")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        if let checkIn = viewModel.checkInDate {
                            Text(CalendarHelper.formattedDate(checkIn))
                                .font(.subheadline)
                                .bold()
                        } else {
                            Text("حدد التاريخ")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }.frame(maxWidth: .infinity, alignment:.leading)
                    
                    VStack{

                        Image(systemName: "arrow.forward")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text("\(viewModel.numberOfNight) ليالٍ")
                            .font(.caption.bold())
                            .foregroundColor(viewModel.numberOfNight > 0 ? .primary : .gray.opacity(0.6))
                    }.frame(maxWidth: .infinity, alignment:.center)

//                    Spacer()
                    
                    // تاريخ الخروج
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("تاريخ الخروج")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        if let checkOut = viewModel.checkOutDate {
                            Text(CalendarHelper.formattedDate(checkOut))
                                .font(.subheadline)
                                .bold()
                        } else {
                            Text("حدد التاريخ")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }


                    }.frame(maxWidth: .infinity, alignment:.trailing)
                    
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)

            

                // زر تأكيد الحجز (مع تعطيله إذا لم تكتمل التواريخ)
                let isReadyToBook = viewModel.checkInDate != nil && viewModel.checkOutDate != nil
                
                // التحقق من اكتمال الاختيار
                if let checkIn = viewModel.checkInDate, let checkOut = viewModel.checkOutDate {
                    
                    // 1. الزر مفعّل وينتقل لصفحة الملخص مباشرة
                    NavigationLink(destination: BookingSummaryView(
                        room: viewModel.room,
                        checkInDate: checkIn,
                        checkOutDate: checkOut,
                        numberOfNight: viewModel.numberOfNight
                    )) {
                        Text("تأكيد الحجز")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .cornerRadius(12)
                    }
                    
                } else {
                    
                    // 2. الزر معطّل في حال عدم اختيار التواريخ بعد
                    Button(action: {}) {
                        Text("تأكيد الحجز")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.4))
                            .cornerRadius(12)
                    }
                    .disabled(true)
                }               //يتعطل الزر لو ماتم اختيار كلا وقت الدخو والخروج ويصبح غير قابل للضغط
            }
            .padding(.horizontal)
            Spacer()
        }
    }
    // تحديد لون خلفية خلية اليوم في التقويم
    private func dayBackgroundColor(isEndpoint: Bool, inRange: Bool, isAvailable: Bool) -> Color {
        // 1. الخروج المبكر (Early Exit):
        // نتحقق أولاً من تفرّغ اليوم؛ إذا كان غير متاح (مثل أيام الماضي)، نرجع لون شفاف فوراً وتتوقف الدالة.
        // فائدة هذه الخطوة: استبعاد الحالات المرفوضة مبكراً لتجنب تكرار شرط (isAvailable &&) في باقي الأسطر.
        guard isAvailable else { return .clear }
        
        // 2. طالما وصلنا هنا، فاليوم متاح حتماً؛ يتبقى فحص نوع الاختيار:
        if isEndpoint {
            return .accentColor            // بداية الحجز (Check-in) أو نهايته (Check-out)
        } else if inRange {
            return Color.blue.opacity(0.2)  // الأيام المظللة الواقعة داخل نطاق الحجز
        } else {
            return .clear                  // يوم متاح عادي ولم يحدده المستخدم
        }
        }
    
}




extension Date {
    func isInSameDayAs(_ date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
    
    func monthName() -> String {
        let calendar = Calendar.current
        let monthSymbols = calendar.monthSymbols
        let month = calendar.component(.month, from: self)
        let currentMonthName = monthSymbols[month - 1]
        return "\(currentMonthName)"
    }
}

#Preview {
    RoomBookingView(room: Room(id: "1", imageName: "test", roomType: RoomType.deluxe, roomName: "test room", capacity: 3, price: 200.0))
}
