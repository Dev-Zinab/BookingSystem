

import Foundation
import FirebaseFirestore // استيراد ضروري لاستخدام Firestore
struct User: Codable,Identifiable {
    let id: String
    var name: String
    let email: String
//    let password: String خطاء تخزينه في قاعدة البيانات عشان نحافظ ع بينات العميل من السرقة 
}
