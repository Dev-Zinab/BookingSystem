//
//  AuthService.swift
//  Booking
//
//  Created by Zinab Zooba on 04/05/2026.
//

import Foundation
import FirebaseAuth

/// A service responsible for handling all authentication-related tasks,
/// including registration, sign-in, and session management.
struct AuthService {
    
    /// Creates a new user account with an email and password, then updates their profile name.
    ///
    /// - Parameters:
    ///   - email: The user's email address.
    ///   - password: The user's password.
    ///   - name: The display name to be set for the user.
    /// - Throws: An error if account creation or profile update fails.
    /// - Returns: The newly created `FirebaseAuth.User` object.
    func signUp(email: String, password: String, name: String) async throws -> FirebaseAuth.User {
        // 1. Create the account
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        let user = result.user
        
        // 2. Update the display name
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = name
        try await changeRequest.commitChanges()
        
        return user
    }
    
    /// Authenticates a user with an email and password.
    /// - Parameters:
    ///   - email: The registered email address.
    ///   - password: The associated password.
    /// - Throws: An error if authentication fails (e.g., wrong password, user not found).
    /// - Returns: An `AuthDataResult` containing user credentials.
    @discardableResult
    func signIn(email: String, password: String) async throws -> AuthDataResult {
        return try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    /// Signs out the currently authenticated user.
    ///
    /// - Throws: An error if the sign-out operation fails.
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    /// Signs in the user anonymously as a guest.
    ///
    /// - Throws: An error if anonymous sign-in fails.
    /// - Returns: An `AuthDataResult` containing the temporary guest credentials.
    func signInAsGuest() async throws -> AuthDataResult {
        return try await Auth.auth().signInAnonymously()
    }
    
    /// The currently authenticated user, if one exists.
    ///
    /// This property reflects the cached state of the Firebase Auth instance.
    var currentUser: FirebaseAuth.User? {
        return Auth.auth().currentUser
    }
}
