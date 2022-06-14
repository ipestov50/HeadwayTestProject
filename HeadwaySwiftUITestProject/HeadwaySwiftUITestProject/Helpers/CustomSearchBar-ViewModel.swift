//
//  CustomSearchBar-ViewModel.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 09.06.2022.
//

import Foundation
import SwiftUI

extension CustomSearchBar {
    final class ViewModel: ObservableObject {
        @Published var items = [Repository]()
        @Published var showingFavs = false
        @Published var savedItems: Set<Int> = [3081286]
        
        var filteredItems: [Repository] {
            if showingFavs {
                print("Saved")
                return items.filter { savedItems.contains($0.id)}
                
            } else {
                return items
            }
        }
        private var db = Database()
        
        init() {
            self.savedItems = db.load()
            self.items = Repository.sampleItems
        }
        
        func sortFavs() {
            withAnimation {
                showingFavs.toggle()
            }
        }
        
        func contains(_ item: Repository) -> Bool {
            savedItems.contains(item.id)
        }
        
        func toggleFav(item: Repository) {
            if contains(item) {
                savedItems.remove(item.id)
            } else {
                savedItems.insert(item.id)
            }
            db.save(items: savedItems)
        }
        
    }
}

