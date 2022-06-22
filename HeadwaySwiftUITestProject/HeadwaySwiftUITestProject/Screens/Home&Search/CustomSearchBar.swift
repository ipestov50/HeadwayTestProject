//  CustomSearchBar.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 07.06.2022.
//

import SwiftUI

struct CustomSearchBar: View {
    
    @StateObject private var vm = ViewModel()
    
    var body: some View {
        
        CustomSearchBarCell()
    }
}

struct CustomSearchBarPreview: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
