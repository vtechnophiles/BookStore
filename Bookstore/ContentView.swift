//
//  ContentView.swift
//  Bookstore
//
//  Created by VTechnoZ on 04/08/22.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct ContentView: View {
    
    @State private var showingEditBookView = false
    @EnvironmentObject var bookVM: BookViewModel
    
    @FirestoreQuery(collectionPath: "books", predicates: []) var books: [Book]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack(alignment: .center) {
                            Image("book")
                                .resizable()
                                .frame(width: 50, height: 70)
                                .cornerRadius(10)
                            
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }

                }
                .onDelete(perform: delete)
            }
            .listStyle(.plain)
            .navigationTitle("BookStore")
            .sheet(isPresented: $showingEditBookView) {
                EditBookView()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingEditBookView = true
                    } label: {
                        Image(systemName: "plus")
                            .padding(8)
                            .background(Color("bookColor"))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                }
            }
        }
        .accentColor(Color("bookColor"))
    }
    
    func delete(at offsets: IndexSet) {
        offsets.forEach { index in
            let book = books[index]
            Task {
                await bookVM.deleteBook(book: book)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
