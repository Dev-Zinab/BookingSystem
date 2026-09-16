import SwiftUI

struct PaymentOptionRow: View {
    let title: String
    let icon: String
    let isSelected: Bool
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(isSelected ? .accentColor : .gray)
                .font(.title3)
            
            Text(title)
                .font(.system(size: 17, weight: .medium))
            
            Spacer()
            
            Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                .foregroundColor(isSelected ? .accentColor : Color.gray.opacity(0.5))
                .font(.title3)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? Color.accentColor : Color.gray.opacity(0.2), lineWidth: isSelected ? 2 : 1)
        )
    }
}

#Preview {
    PaymentOptionRow(title: "بطاقة ائتمان", icon: "creditcard", isSelected: true)
}
