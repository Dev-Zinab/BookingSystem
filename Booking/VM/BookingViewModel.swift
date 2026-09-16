import SwiftUI
import Observation

@Observable
class BookingViewModel {
    var selectedDate = Date()
    var displayedMonth = Date()
    var checkInDate: Date?
    var checkOutDate: Date?
    var isLoading: Bool = false
    var bookingSuccessful = false
    let calendar = Calendar(identifier: .gregorian)
    let room: Room
    private let bookingService = BookingService()
    init(room: Room) {
            self.room = room
        }
    // 1. التنقل للشهر التالي باستخدام right من كودك القديم
    func nextMonth() {
        if let newMonth = CalendarHelper.right(from: displayedMonth) {
            displayedMonth = newMonth
        }
    }
    
    // 2. التحقق ومنع الرجوع لأشهر سابقة
    var canGoToPreviousMonth: Bool {
        Calendar.current.compare(displayedMonth, to: Date(), toGranularity: .month) == .orderedDescending
    }
    
    // 3. التنقل للشهر السابق باستخدام left من كودك القديم
    func previousMonth() {
        guard canGoToPreviousMonth else { return }
        if let previous = CalendarHelper.left(from: displayedMonth) {
            displayedMonth = previous
        }
    }
    
    // 4. جلب أيام الشهر مع الخانات الفارغة في البداية
    func daysInCurrentMonth() -> [Date?] {
        CalendarHelper.daysInMonth(from: displayedMonth)
    }
    
    func confirmBooking(roomId: String, userId: String) async {
        isLoading = true
        defer { isLoading = false }
        do {
            let newBooking = Booking(id: UUID().uuidString, userId: userId, date: self.selectedDate, duration: 1, roomId: roomId, status: .booked)
            try await bookingService.createBooking(booking: newBooking)
            bookingSuccessful = true
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func selectDate(_ checkedDate: Date) {
        if checkInDate == nil || (checkOutDate != nil && checkInDate != nil) {
            checkInDate = checkedDate
            checkOutDate = nil
        }
        // مااقدر اقارن بين متغيرين نوعهم  Date? and Date
        // لازم نفس القمية بالضبط ممكن اسوي فتح اجباري او نفس ماعملت انشادت متغير جديد واقارنه بالمتغير الجديد
        else if let checkIn = checkInDate, checkOutDate == nil, checkedDate > checkIn {
            checkOutDate = checkedDate
        }
        // إذا كان التاريخ المختار أقدم من تاريخ الدخول الحالي
        else if let checkIn = checkInDate, checkedDate <= checkIn {
            checkInDate = checkedDate
            checkOutDate = nil
        }
        
    }
    
    func isSelectedEndpoint (_ date: Date) -> Bool {
        if let checkin=checkInDate, calendar.isDate(date, inSameDayAs: checkin) {
            return true
        }
        if let checkout=checkOutDate, calendar.isDate(date, inSameDayAs: checkout) {
            return true
        }
        return false
        
    }
    
    func isInRange (_ date: Date) -> Bool {
        if let checkin=checkInDate, let checkout=checkOutDate {
            return (checkin...checkout).contains(date)
            
        }
        return false
    }
    var numberOfNight: Int {
        guard let checkin=checkInDate, let checkout=checkOutDate  else {
            return 0
        }
        return calendar.dateComponents([.day], from: checkin, to: checkout).day ?? 0
    }
    
    var totalPrice : Double {
        var pricePerNight = room.price
        return Double(numberOfNight) * pricePerNight
    }
}

        


