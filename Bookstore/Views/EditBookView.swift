//
//  EditBookView.swift
//  Bookstore
//
//  Created by VTechnoZ on 04/08/22.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct EditBookView: View {
    
    @State private var title = ""
    @State private var author = ""
    @State private var price = 0
    
    var book: Book?
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject var bookVM: BookViewModel
    
    var bookHeading: String {
        if let _ = book {
            return "Edit Book"
        } else {
            return "Add Book"
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(bookHeading)
                    .foregroundColor(Color("bookColor"))
                    .font(.largeTitle.bold())
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(Color("bookColor"))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
            }
            .padding(.vertical, 30)
            
            Spacer()
            
            VStack(spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Title:")
                        .foregroundColor(Color("bookColor").opacity(0.6))
                    TextField("Enter Title", text: $title)
                        .textFieldStyle(.roundedBorder)
                }
                
                VStack(alignment: .leading) {
                    Text("Author:")
                        .foregroundColor(Color("bookColor").opacity(0.6))
                    TextField("Enter Author", text: $author)
                        .textFieldStyle(.roundedBorder)
                }
                
                VStack(alignment: .leading) {
                    Text("Price:")
                        .foregroundColor(Color("bookColor").opacity(0.6))
                    TextField("Enter Price", value: $price, format: .number)
                        .textFieldStyle(.roundedBorder)
                }
            }
            
            Spacer()
            
            Button {
                EditData()
            } label: {
                Text(bookHeading)
                    .bold()
                    .frame(maxWidth: .infinity, maxHeight: 55)
                    .background(Color("bookColor"))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            
            Spacer()
            
        }
        .padding(.horizontal)
        .onAppear {
            if let book = book {
                title = book.title
                author = book.author
                price = book.price
            }
        }
        
    }
    
    func EditData() {
        let bookData: [String: Any] = [
            "title": title,
            "author": author,
            "price": price,
            "created": FieldValue.serverTimestamp()
        ]
        
        if let book = book {
            // Update Book View
            guard let bookId = book.id else {
                return
            }
            
            Task {
                await bookVM.updateBook(bookId: bookId, bookData: bookData)
                if bookVM.taskCompleted {
                    dismiss()
                }
            }
            
            
        } else {
            // Add Book View
            Task {
                await bookVM.addBook(bookData: bookData)
                if bookVM.taskCompleted {
                    dismiss()
                }
            }
        }
        
        
    }
    
    
}

struct EditBookView_Previews: PreviewProvider {
    static var previews: some View {
        EditBookView()
    }
}
