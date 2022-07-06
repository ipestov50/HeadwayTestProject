//
//  Favorites.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 16.06.2022.
//

import Foundation
import SwiftUI

struct FavoritesView: View {
    
    @StateObject private var vm = FavoritesViewModel()
    
    var body: some View {
        ZStack {  
            List {
                ForEach(vm.savedItems) { item in
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
                            vm.selectedRepository = item
                            vm.isShowingDetail = true
                        }
                    }
                    .blur(radius: vm.isShowingDetail ? 20 : 0)
                    .listRowSeparator(.hidden)
                }
                .onDelete(perform: deleteItems)
            }
            .disabled(vm.isShowingDetail)
            
            if vm.savedItems.isEmpty {
                EmptyState(imageName: "empty-list",
                           message: "You have no items in your Favorites. \nPlease add a repository!")
            }
            
            if vm.isShowingDetail {
                FavoritesDetailView(isShowingDetail: $vm.isShowingDetail, repository: vm.selectedRepository!)
            }
        }
        .navigationTitle("Favorites")
    }
    
    func deleteItems(at offesets: IndexSet) {
        offesets.forEach { index in
            vm.db.delete(item: vm.savedItems[index])
        }
        vm.savedItems.remove(atOffsets: offesets)
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
