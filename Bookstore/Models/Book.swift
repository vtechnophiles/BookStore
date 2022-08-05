//
//  Book.swift
//  Bookstore
//
//  Created by VTechnoZ on 04/08/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift



struct Book: Codable, Identifiable {
    @DocumentID var id: String?
    var title: String
    var author: String
    var price: Int
    var created: Timestamp
}
