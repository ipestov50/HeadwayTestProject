//
//  MainTabView.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 16.06.2022.
//

import SwiftUI

struct MainTabView: View {
    @State var selectedIndex = 0
    let icons = [
        "house",
        "heart"
    ]
    
    var body: some View {
        ZStack {
            switch selectedIndex {
            case 0:
                NavigationView {
                    VStack {
                        Home()
                    }
                    .navigationTitle("Search Repositories")
                    
                }
            default:
                    FavoritesView()
//                .navigationTitle("Favorites")
            }
        }
        
        HStack() {
            ForEach(0..<2, id: \.self) { number in
                Spacer()
                Button(action: {
                    self.selectedIndex = number
                }) {
                    Image(systemName: icons[number])
                        .font(.system(size: 25, weight: .regular, design: .default))
                        .foregroundColor(selectedIndex == number ? .blue : .yellow)
                }
                Spacer()
            }
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
