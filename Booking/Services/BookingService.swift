//
//  BookingService.swift
//  Booking
//
//  Created by Zinab Zooba on 08/08/2026.
//

import SwiftUI
import Firebase

struct BookingService {
    private  let db = Firestore.firestore()
private var isLoading: Bool = false
     func createBooking (booking: Booking) async throws{

        try  await db.collection( "bookings").document(booking.id).setData(from: booking)
    }
}
