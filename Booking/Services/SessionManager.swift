//
//  Untitled.swift
//  Booking
//
//  Created by Zinab Zooba on 04/05/2026.
//

import Foundation
import FirebaseAuth

@Observable class SessionManager {
    /// The current authentication status of the user.
    var isAuthenticated: Bool = false
    
    /// A handle for the authentication state listener.
    /// Stored to allow for removal when the object is deallocated.
    private var handle: AuthStateDidChangeListenerHandle?
    
    init() {
        self.isAuthenticated = Auth.auth().currentUser != nil
        
        // Using [weak self] prevents retain cycles, ensuring this instance can be
        // deallocated safely even if the listener closure is held in memory.
        self.handle = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            self?.isAuthenticated = user != nil
        }
    }
    
    /// Triggered automatically upon deallocation (happen inside Xcode).
    /// Explicitly removes the listener to prevent memory leaks and unnecessary background activity.
    deinit {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
