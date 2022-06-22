//  Home.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 07.06.2022.
//

import SwiftUI

struct Home: View {
    
    var body: some View {

            VStack {
                CustomSearchBar()
                Spacer()
            }
    }
    
}

struct HomeProvider: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
