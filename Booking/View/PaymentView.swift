//
//  PaymentView.swift
//  Booking
//
//  Created by Zinab Zooba on 20/08/2026.
//

import SwiftUI
enum PaymentMethod {
    case applePay
    case card
}

struct PaymentView: View {
    @State private var selectedMethod: PaymentMethod = .card
    @State private var cardNumber = ""
    @State private var expiryDate = ""
    @State private var cvv = ""
    @State private var cardHolderName = ""
    
    let room: Room
    let numberOfNight: Int
    
    var totalPrice: Double {
        Double(numberOfNight) * room.price
    }
    
    // التحقق من اكتمال بيانات البطاقة
    var isCardFormValid: Bool {
        !cardNumber.isEmpty && !expiryDate.isEmpty && !cvv.isEmpty && !cardHolderName.isEmpty
    }

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 20) {
                    // 1. عرض السعر
                    VStack(spacing: 4) {
                        Text("السعر الإجمالي")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        Text(totalPrice, format: .currency(code: "SAR"))
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.primary)
                    }
                    .padding(.top)

                    // 2. خيارات الدفع
                    VStack(alignment: .trailing, spacing: 10) {
                        Text("طريقة الدفع")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        PaymentOptionRow(
                            title: "Apple Pay",
                            icon: "apple.logo",
                            isSelected: selectedMethod == .applePay
                        )
                        .onTapGesture {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                selectedMethod = .applePay
                            }
                        }

                        PaymentOptionRow(
                            title: "بطاقة ائتمان",
                            icon: "creditcard",
                            isSelected: selectedMethod == .card
                        )
                        .onTapGesture {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                                selectedMethod = .card
                            }
                        }
                    }

                    // 3. حقول إدخال البطاقة (تظهر محاذاة لليمين)
                    if selectedMethod == .card {
                        VStack(alignment: .trailing, spacing: 14) {
                            VStack(alignment: .trailing, spacing: 4) {
                                Text("رقم البطاقة")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                TextField("1234 5678 9101 1121", text: $cardNumber)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(.roundedBorder)
                            }

                            HStack(spacing: 12) {
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("CVV")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    TextField("123", text: $cvv)
                                        .keyboardType(.numberPad)
                                        .textFieldStyle(.roundedBorder)
                                }

                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("تاريخ الانتهاء")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    TextField("MM/YY", text: $expiryDate)
                                        .keyboardType(.numberPad)
                                        .textFieldStyle(.roundedBorder)
                                }
                            }

                            VStack(alignment: .trailing, spacing: 4) {
                                Text("اسم حامل البطاقة")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                TextField("الاسم كما هو مكتوب على البطاقة", text: $cardHolderName)
                                    .textFieldStyle(.roundedBorder)
                            }
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(12)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }
                .padding(.horizontal)
            }

            // 4. زر الدفع الرئيسي
            Button(action: handlePayment) {
                Text(selectedMethod == .applePay ? "الدفع بواسطة Apple Pay" : "تأكيد ودفع \(totalPrice.formatted()) ر.س")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isButtonDisabled ? Color.gray.opacity(0.5) : Color.accentColor)
                    .cornerRadius(12)
            }
            .disabled(isButtonDisabled)
            .padding(.horizontal)
            .padding(.bottom, 8)
        }
    }

    private var isButtonDisabled: Bool {
        selectedMethod == .card && !isCardFormValid
    }

    private func handlePayment() {
        // تنفيذ عملية الدفع هنا
    }
}

#Preview {
    PaymentView(room: Room.sampleData[0], numberOfNight: 4)
}
