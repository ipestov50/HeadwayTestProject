//
//  ModelView.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 14.06.2022.
//

import Foundation
import SwiftUI


class ModelView: ObservableObject {
    
    @Published var isHomeLoad = false
    @Published var isFavorites = false
    
    init() {
        
        // load initial data
        print("Home Data Loaded")
    }
    
    func loadHome() {
        
        print("home loaded")
        isHomeLoad = true
    }
    
    func favoritesLoad() {
        
        print("favorites loaded")
        isFavorites = true
    }
}
