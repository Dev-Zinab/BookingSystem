

import Foundation

struct User: Codable,Identifiable {
    let id: String
    var name: String
    let email: String
    let password: String
}
struct Admin: Codable,Identifiable {
    let id: String
    var name: String
    var email: String
    var password: String
}

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
