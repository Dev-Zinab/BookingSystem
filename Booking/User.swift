

import Foundation

struct User: Codable,Identifiable {
    let id: UUID
    var name: String
    let email: String
    let password: String
}
struct Admin: Codable,Identifiable {
    let id: UUID
    var name: String
    var email: String
    var password: String
}

struct Booking: Codable,Identifiable {
    let id: UUID
    var userId: UUID
    var date: Date
    var duration: Int
    var roomId: UUID
    var status: String
}

struct Room: Codable,Identifiable {
    let id: UUID
    var name: String
    var capacity: Int
    var price: Double
}

struct slot: Codable,Identifiable {
    let id: UUID
    var userId: UUID
    var date: Date
    var status: String
    var roomId: UUID
    
}

enum status: String, Codable {
    case booked = "booked"
    case cancelled = "cancelled"
    case available = "available"
}
