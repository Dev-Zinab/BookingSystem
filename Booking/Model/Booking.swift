//
//  Booking.swift
//  Booking
//
//  Created by Zinab Zooba on 28/04/2026.
//

struct Booking: Codable,Identifiable {
    let id: String
    var userId: String
    var date: Date
    var duration: Int
    var roomId: UUID
    var status: Status
}

struct Room: Codable,Identifiable {
    let id: String
    var name: RoomName
    var capacity: Int
    var price: Double
}

struct Slot: Codable,Identifiable {
    let id: String
    var userId: String?
    var date: Date
    var status: Status
    var roomId: String
    
}

enum Status: String, Codable {
    case booked = "booked"
    case cancelled = "cancelled"
    case available = "available"
}
enum RoomName: String, Codable {
    case single = "single"
    case double = "double"
    case deluxe = "deluxe"
}
