//  Home.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 07.06.2022.
//

import SwiftUI

struct Home: View {
    @State var selectedTab = "house"
    
    @StateObject var searchData = SearchRepositories()
    var body: some View {
        
            VStack {
                CustomSearchBar(searchData: searchData)
                
                Spacer()
            }
        
        // onChange will fire the block whenever the content is changed. Thus, the data fetch rate will be high since for every letter being typed it will be fetched. So we are using a simple logic here if the user stops typing for 0.4 sec then we start fetching the daya.
        .onChange(of: searchData.query) { newData in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                if newData == searchData.query {
                    print("search \(newData)")
                    
                    if searchData.query != "" {
                        // searcing Repository...
                        searchData.page = 1
                        searchData.find()
                    } else {
                        // removing all searched Data...
                        searchData.searchedRepository.removeAll()
                    }
                }
            }
            print(newData)
        }
        
    }
    
}

struct HomeProvider: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
