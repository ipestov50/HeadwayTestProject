//
//  CustomSearchBarCell.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 22.06.2022.
//

import SwiftUI

struct CustomSearchBarCell: View {
    
    @StateObject var vm = ViewModel()
    
    let customSearchBar = CustomSearchBar()
    
    var body: some View {
        VStack(spacing: 0) {
            
                HStack(spacing: 12) {
                    
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    
                    TextField("Find Repository", text: $vm.query)
                        .autocapitalization(.none)
                        .onChange(of: vm.query) { newValue in
                            vm.onChange(query: newValue)
                        }
                    if vm.isLoading {
                        LoadingView()
                    } 
                }
            .alert(item: $vm.alertItem) { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: alertItem.dismissButton)
            }
            .padding(.vertical, 10)
            .padding(.horizontal)
            
            
            if !vm.data.isEmpty {
                ScrollView(.vertical, showsIndicators: true) {
                    
                    LazyVStack(alignment: .leading,spacing: 0) {
                        // Safe Wrap
                        ForEach(vm.data,id: \.self) { data in
 
                            HStack {
                                VStack(alignment: .leading, spacing: 0) {
                                    Text(data.repository.name ?? "No name")
                                    Link(data.repository.name ?? "No name", destination: URL(string: data.repository.html_url ?? "https://google.com")!)
                                        .simultaneousGesture(TapGesture().onEnded {
                                            vm.toggleFav(item: data.repository)
                                        })
                                }
                                
                                Spacer()
                                Image(systemName: data.isLiked ? "heart.fill" : "heart")
                                    .foregroundColor(.pink)
                                    .onTapGesture {
                                        vm.toggleFav(item: data.repository)
                                    }
                                    .offset(y: -12)
                                Text(data.isLiked ? "Seen" : "")
                                    .foregroundColor(.green)
                                    .offset(y: -12)
                            }
                            .padding(.horizontal)
                            
                            .onAppear {
                                vm.onAppear(repository: data.repository)
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

struct CustomSearchBarCell_Previews: PreviewProvider {
    static var previews: some View {
        CustomSearchBarCell()
    }
}
