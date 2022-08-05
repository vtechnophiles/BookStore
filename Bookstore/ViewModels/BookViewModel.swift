//
//  BookViewModel.swift
//  Bookstore
//
//  Created by VTechnoZ on 04/08/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


class BookViewModel: ObservableObject {
    
    private let db = Firestore.firestore()
    
    @Published var taskCompleted = false
    
    
    @MainActor
    func addBook(bookData: [String: Any]) async {
        
        do {
            try await db.collection("books").document().setData(bookData)
            taskCompleted = true
            print("Debug: Added data successfully")
            
        } catch {
            print("Debug: Failed to add data \(error.localizedDescription)")
        }
        
    }
    
    
    @MainActor
    func updateBook(bookId: String, bookData: [String: Any]) async {
        
        do {
            try await db.collection("books").document(bookId).updateData(bookData)
            taskCompleted = true
            print("Debug: Updated data successfully")
            
        } catch {
            print("Debug: Failed to update data \(error.localizedDescription)")
        }
        
    }
    
    func deleteBook(book: Book) async {
        guard let bookId = book.id else {
            print("Debug: Unable to find book id")
            return
        }
        
        do {
            try await db.collection("books").document(bookId).delete()
            print("Debug: Book Deleted successfully")
        } catch {
            print("Debug: Unable to delete book \(error.localizedDescription)")
        }
    }
    
}
