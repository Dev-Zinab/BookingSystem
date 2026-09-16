//
//  Room.swift
//  Booking
//
//  Created by Zinab Zooba on 03/07/2026.



import SwiftUI

struct RoomCard: View {
    let room: Room
    var body: some View {
        VStack(alignment: .leading){
            
            HStack{
                Image("\(room.imageName)")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .cornerRadius(16)
                    
                Spacer()
            VStack{
                Text(room.roomName)
                Text("\(room.rating ?? 3.0,specifier: "%.1f")/5.0")
            }.padding(.trailing, 10)
            }
            
        }.cardStyle()
    }
}

#Preview {
    RoomCard(room: (Room.sampleData[0])); RoomCard(room: (Room.sampleData[1]));
    RoomCard(room: (Room.sampleData[2])); RoomCard(room: (Room.sampleData[3]))
}
