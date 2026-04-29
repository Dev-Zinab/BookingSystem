

import Foundation

struct User: Codable,Identifiable {
    let id: String
    var name: String
    let email: String
    let password: String
}
