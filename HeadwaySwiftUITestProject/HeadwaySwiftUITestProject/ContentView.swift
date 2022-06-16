//
//  ContentView.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 06.06.2022.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    var body: some View {
        
        NavigationView {
            Home()
                .preferredColorScheme(.dark)
                .navigationTitle("Repositories")
        }
    }
}

