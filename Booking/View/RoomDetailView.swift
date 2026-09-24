//
//  RoomDetailView.swift
//  Booking
//
//  Created by Zinab Zooba on 13/07/2026.
//

import SwiftUI

struct RoomDetailView: View {
    let room: Room
    @State private var isfavorite: Bool = false
    @Binding var path: NavigationPath
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // 1. صورة القاعة بحواف منحنية وظل ناعم
                Image(room.imageName)
                    .resizable()
                    .aspectRatio(16/10, contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.12), radius: 10, x: 0, y: 5)
                    .padding(.horizontal)

                VStack(alignment: .leading, spacing: 18) {
                    
                    // 2. عنوان القاعة + تقييم النجوم + السعر
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(room.roomName)
                                .font(.title2)
                                .bold()

                            // النجوم مع إظهار الرقم
                            HStack(spacing: 3) {
                                ForEach(1..<6, id: \.self) { star in
                                    let isFill = Double(star) <= (room.rating ?? 0.0)
                                    Image(systemName: isFill ? "star.fill" : "star")
                                        .font(.caption)
                                        .foregroundStyle(isFill ? .yellow : Color(.systemGray4))
                                }
                                
                                if let rating = room.rating {
                                    Text(String(format: "%.1f", rating))
                                        .font(.caption)
                                        .bold()
                                        .foregroundColor(.secondary)
                                        .padding(.leading, 4)
                                }
                            }
                        }

                        Spacer()

                        // عرض السعر بطريقة مرتبة
                        VStack(alignment: .trailing, spacing: 2) {
                            Text("$\(room.price, specifier: "%.1f")")
                                .font(.title3)
                                .bold()
                                .foregroundColor(.blue)
                            Text("لكل ليلة")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                    }

                    Divider()

                    // 3. وصف القاعة
                    VStack(alignment: .leading, spacing: 8) {
                        Text("الوصف")
                            .font(.headline)

                        Text(room.description ?? room.roomName)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineSpacing(4)
                    }

                    Divider()

                    // 4. المميزات (Amenities) على شكل كبسولات أنيقة (Chips)
                    VStack(alignment: .leading, spacing: 12) {
                        Text("المميزات والخدمات")
                            .font(.headline)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(room.amenities, id: \.self) { amenity in
                                    HStack(spacing: 8) {
                                        Image(systemName: amenity.IconName)
                                            .font(.system(size: 16, weight: .semibold))
                                            .foregroundColor(.blue)
                                    }
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 12)
                                    .background(Color.blue.opacity(0.08))
                                    .clipShape(Capsule())
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationTitle(room.roomName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    isfavorite.toggle()
                }) {
                    Image(systemName: isfavorite ? "heart.fill" : "heart")
                        .foregroundColor(isfavorite ? .red : .gray)
                        .symbolEffect(.bounce, value: isfavorite)
                }
            }
        }
        // 5. شريط زر "احجز الآن" مائل للأسفل ومثبت (Sticky Bottom Bar)
        .safeAreaInset(edge: .bottom) {
            VStack {
                NavigationLink(destination: RoomBookingView(room: room, path: $path)) {
                    
                    Text("احجز الآن")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 52)
                        .background(Color.blue)
                        .cornerRadius(16)
                        .shadow(color: .blue.opacity(0.25), radius: 8, x: 0, y: 4)
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .padding(.bottom, 6)
            .background(.ultraThinMaterial)
        }
    }
}

#Preview {
    RoomDetailView(
        room: Room.sampleData[0],
        path: .constant(NavigationPath())
    )
}
