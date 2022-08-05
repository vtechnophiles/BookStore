//
//  DetailView.swift
//  Bookstore
//
//  Created by VTechnoZ on 04/08/22.
//

import SwiftUI
import FirebaseFirestore

struct DetailView: View {
    
    let book: Book
    
    @State private var showingEditView = false
    
    var body: some View {
        ScrollView {
            VStack {
                Image("book")
                    .resizable()
                    .frame(maxWidth: .infinity)
                    .frame(height: 300)
                
                
                VStack(alignment: .leading, spacing: 20) {
                    BookRow(label: "Book Title", value: book.title)
                    BookRow(label: "Book Author", value: book.author)
                    BookRow(label: "Book Price", value: "$\(book.price)")
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingEditView = true
                } label: {
                    Text("update")
                }
            }
        }
        .sheet(isPresented: $showingEditView) {
            EditBookView(book: book)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(book: Book(title: "", author: "", price: 4, created: Timestamp(date: Date())))
    }
}

struct BookRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack(spacing: 20) {
            Spacer()
            Text(label)
            Text(value).bold()
            Spacer()
        }
        .font(.body)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .background(Color("bookColor"), in: RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}
