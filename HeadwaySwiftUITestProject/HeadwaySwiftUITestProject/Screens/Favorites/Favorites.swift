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
                            favVm.selectedRepository = item
                            favVm.isShowingDetail = true
                        }
                    }
                    .blur(radius: favVm.isShowingDetail ? 20 : 0)
                }
            }
            .disabled(favVm.isShowingDetail)
            
            if favVm.isShowingDetail {
                FavoritesDetailView(isShowingDetail: $favVm.isShowingDetail, repository: favVm.selectedRepository!)
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
