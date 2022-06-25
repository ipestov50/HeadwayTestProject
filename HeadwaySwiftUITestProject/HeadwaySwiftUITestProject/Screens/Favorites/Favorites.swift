//
//  Favorites.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 16.06.2022.
//

import Foundation
import SwiftUI

struct Favorites: View {
    @StateObject private var favVm = FavoritesViewModel()
    @State private var isShowingDetail = false
    @State private var selectedRepository: Repository?
    
    var body: some View {
        ZStack {  
            List {
                ForEach(favVm.savedItems) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name ?? "No name")
                                .font(.headline)
                            Spacer()
                            Text("Short details...")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .onTapGesture {
                            selectedRepository = item
                            isShowingDetail = true
                        }
                    }
                    .blur(radius: isShowingDetail ? 20 : 0)
                }
            }
            .disabled(isShowingDetail)
            
            if isShowingDetail {
                FavoritesDetailView(repository: selectedRepository!, isShowingDetail: $isShowingDetail)
            }
        }
        .navigationTitle("Favorites")
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Favorites()
    }
}
