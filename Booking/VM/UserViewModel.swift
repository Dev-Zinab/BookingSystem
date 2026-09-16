//
//  UserViewModel.swift
//  Booking
//
//  Created by Zinab Zooba on 07/05/2026.
//

import Foundation

@Observable class UserViewModel {
    var name = ""
    var isLoading = false
    var errorMessage: String?
    static let guestName = "Guest"

    private let userService = UserService()
     var isInputValid: Bool {
         guard !name.trimmingCharacters(in: .whitespaces).isEmpty else {
             errorMessage = "Name is required"
             return false
         }
         guard name.count >= 3  else {
             errorMessage = "Name should be at least 3 characters long"
             return false
         }
         
         errorMessage = nil
         return true
    }
    func saveUser(uid: String, email: String) async {
        isLoading = true
        let newUser = User(id: uid, name: self.name, email: email)
        do {
            try await userService.saveUserData(user: newUser )
        }
        catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func fetchCurrentUser(_ uid: String) async {
        isLoading = true
        do {
            let fetchedUser  = try await userService.fetchUserData(uid: uid)
            
            self.name = fetchedUser.name
        }
        catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    func resetFields() {
        name = ""
        errorMessage = nil
    }
}
// Test.de@deelover.com
//123456@Aa
