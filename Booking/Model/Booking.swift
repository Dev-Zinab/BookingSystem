//
//  Booking.swift
//  Booking
//
//  Created by Zinab Zooba on 28/04/2026.
//
import Foundation
struct Booking: Codable,Identifiable {
    let id: String
    var userId: String
    var date: Date
    var duration: Int
    var roomId: String
    var status: Status
}



struct Room: Codable,Identifiable {
    let id: String
    var imageName: String
    var roomType: RoomType
    var roomName: String
    var description: String?
    var rating: Double?
    var capacity: Int
    var price: Double
    var isAvailable: Bool = true
    var amenities: [Amenities] = []
    

    
}
extension Room {
    static let sampleData: [Room] = [
        .init(
            id: "1",
            imageName: "room1",
            roomType: .deluxe,
            roomName: "الجناح الملكي",
            description: "تجربة إقامة فاخرة تتميز بإطلالة ساحرة وتصميم عصري مريح.",
            rating: 4.9,
            capacity: 2,
            price: 1800,
            amenities: [Amenities.breakfast, Amenities.wifi,Amenities.balcony, Amenities.parking]
        ),
        .init(
            id: "2",
            imageName: "room2",
            roomType: .deluxe,
            roomName: "الغرفة الكلاسيكية",
            description: "أجواء دافئة ومثالية للاسترخاء مع كافة التجهيزات الحديثة.",
            rating: 4.7,
            capacity: 2,
            price: 950,
            amenities: [Amenities.balcony, Amenities.wifi]
        ),
        .init(
            id: "3",
            imageName: "room3",
            roomType: .deluxe,
            roomName: "غرفة البساطة",
            description: "تصميم مريح وأنيق يحتوي على كل ما تحتاجه لإقامة هادئة.",
            rating: 4.5,
            capacity: 2,
            price: 650,
            amenities: [Amenities.breakfast,Amenities.wifi]
        ),
        .init(
            id: "4",
            imageName: "room4",
            roomType: .deluxe,
            roomName: "الجناح العائلي",
            description: "مساحة واسعة ومناسبة للقروبات والعائلات لإقامة ممتعة.",
            rating: 4.8,
            capacity: 4,
            price: 2100,
            amenities: [Amenities.breakfast,Amenities.wifi, Amenities.pets, Amenities.tv]
        )
    ]
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
enum RoomType: String, Codable {
    case single = "single"
    case double = "double"
    case deluxe = "deluxe"
}

enum Amenities: String, Codable {
    case balcony = "window.vertical.open"
    case kitchen = "kitchen"
    case parking = "parking"
    case wifi = "wifi"
    case tv = "tv"
    case pets = "pets"
    case breakfast = "breakfast"
    
    
    var IconName: String{
        switch self {
        case .balcony:
            return "window.vertical.open"
        case .kitchen:
            return "fork.knife"
        case .parking:
            return "p.circle.fill"
        case .wifi:
            return "wifi"
        case .tv:
            return "tv"
        case .pets:
            return "pawprint.fill"
        case .breakfast:
            return "cup.and.saucer.fill"
        }
    }
}
