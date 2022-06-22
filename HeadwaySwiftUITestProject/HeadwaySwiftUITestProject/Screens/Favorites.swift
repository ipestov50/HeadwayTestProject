//
//  Favorites.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 16.06.2022.
//

import Foundation
import SwiftUI

struct Favorites: View {
    // to do add view model
    @StateObject private var favVm = FavoritesViewModel()
    
    
    var body: some View {
        
        VStack {
            
            List {
                ForEach(favVm.savedItems) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name ?? "No name")
                                .font(.headline)
                            Spacer()
                            Text(item.description ?? "No description")
                                .font(.subheadline)
                        }
                        Spacer()
                        
                        
                    }
                }
            }
            
        }
    }
    
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Favorites()
    }
}
