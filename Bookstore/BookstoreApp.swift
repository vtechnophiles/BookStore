//
//  BookstoreApp.swift
//  Bookstore
//
//  Created by VTechnoZ on 04/08/22.
//

import SwiftUI
import FirebaseCore

@main
struct BookstoreApp: App {
    
    @StateObject var bookVM = BookViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bookVM)
        }
    }
}
