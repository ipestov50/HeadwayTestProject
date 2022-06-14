//  CustomSearchBar.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 07.06.2022.
//

import SwiftUI

struct CustomSearchBar: View {
    @StateObject private var vm = ViewModel()
    
    @ObservedObject var searchData: SearchRepositories
    var body: some View {
        
        VStack(spacing: 0) {
            HStack(spacing: 12) {
                
                Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .foregroundColor(.gray)
                
                TextField("Find Repository", text: $searchData.query)
                    .autocapitalization(.none)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            
            
            if !searchData.searchedRepository.isEmpty {
                ScrollView(.vertical, showsIndicators: true) {
                    
                    LazyVStack(alignment: .leading,spacing: 0) {
                        
                        // Safe Wrap
                        ForEach(searchData.searchedRepository,id: \.self) { repository in
                            HStack {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(repository.name)
                                    Link(repository.name, destination: URL(string: repository.html_url)!)
                                }
                                Spacer()
                                Image(systemName: vm.contains(repository) ? "heart.fill" : "heart")
                                    .foregroundColor(.pink)
                                    .onTapGesture {
                                        vm.toggleFav(item: repository)
                                    }
                                    .offset(y: -10)
                            }
                            
                            .padding(.horizontal)
                            .onAppear {
                                // stopping search until 3rd page
                                if repository.node_id == searchData.searchedRepository.last?.node_id && searchData.page <= 3 {
                                    searchData.page += 1
                                    searchData.find()
                                }
                                
                            }
                            
                        }

                    }
                    .padding(.top)
                }
                .frame(height: 240)
            }
            
        }
        .background(.blue)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding()
    }
}

struct CustomSearchBarPreview: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
