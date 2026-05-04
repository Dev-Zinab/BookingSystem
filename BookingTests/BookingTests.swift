//
//  BookingTests.swift
//  BookingTests
//
//  Created by Zinab Zooba on 03/05/2026.
//

    import XCTest
    // استبدلي "Booking" باسم مشروعك الحقيقي
    @testable import Booking

    final class AuthViewModelTests: XCTestCase {

        func testPasswordStrength_WhenPasswordIsShort_ShouldReturnFalse() {
            // 1. Arrange (التجهيز)
            let viewModel = AuthViewModel()
            let weakPassword = "123"
            
            // 2. Act (التنفيذ)
            let result = viewModel.isPasswordStrong(weakPassword)
            
            // 3. Assert (التحقق)
            XCTAssertFalse(result, "الباسورد قصير جداً، يجب أن تفشل الدالة")
        }
        
        func testPasswordStrength_WhenPasswordIsStrong_ShouldReturnTrue() {
            // 1. Arrange
            let viewModel = AuthViewModel()
            let strongPassword = "Password123"
            
            // 2. Act
            let result = viewModel.isPasswordStrong(strongPassword)
            
            // 3. Assert
            XCTAssertTrue(result, "الباسورد قوي ومستوفٍ للشروط، يجب أن تنجح الدالة")
        }
        
        func testPasswordStrength_WhenMissingNumbers_ShouldReturnFalse() {
            let viewModel = AuthViewModel()
            // باسورد يحتوي حروف فقط
            let invalidPassword = "PasswordOnly"
            
            let result = viewModel.isPasswordStrong(invalidPassword)
            
            XCTAssertFalse(result, "الباسورد لا يحتوي أرقاماً، يجب أن تفشل الدالة")
        }
        
        // 1. اختبار إيميل ينتهي بـ .sa (هل سيقبله؟)
        func test_EmailValidation_WithSaudiDomain_ShouldReturnTrue() {
            let viewModel = AuthViewModel()
            let saudiEmail = "zainab@example.sa" // هنا .sa وليس .com
            
            let result = viewModel.isValidEmail(saudiEmail)
            
            XCTAssertTrue(result, "يجب أن يقبل النطاق .sa")
        }

        // 2. اختبار إيميل لا يحتوي على @ (هل سيرفضه؟)
        func test_EmailValidation_MissingAtSign_ShouldReturnFalse() {
            let viewModel = AuthViewModel()
            let badEmail = "zainab.gmail.com"
            
            let result = viewModel.isValidEmail(badEmail)
            
            XCTAssertFalse(result, "يجب أن يرفض الإيميل لأنه لا يحتوي على @")
        }
    }


