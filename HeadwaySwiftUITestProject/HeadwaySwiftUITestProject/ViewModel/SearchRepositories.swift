//  SearchRepositories.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 07.06.2022.
//

import SwiftUI

class SearchRepositories: ObservableObject {
    
    @Published var searchedRepository: [Repository] = []
    
    // Repository query...
    @Published var query = ""
    
    // Current Result Page
    @Published var page = 1
    
    // Sort by stars
    @Published var sort = "stars"
    
    func find() {
        // removing spaces
        let searchQuery = query.replacingOccurrences(of: " ", with: "%20")
        
        let url = "https://api.github.com/search/repositories?q=\(searchQuery)&per_page=30&sort=\(sort)&page=\(page)&order=desc&since=daily"
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { data, _, err in
            
            guard let jsonData = data else { return }
                
            do {
                let repositories = try JSONDecoder().decode(Results.self, from: jsonData)
                // appending to searched Repositories...
                DispatchQueue.main.async {
                    // removing data if its new request...
                    if self.page == 1 {
                        self.searchedRepository.removeAll()
                    }
                    // checking if any data already loaded is again loaded...
                    // ignores already loaded
                    self.searchedRepository = Array(Set(self.searchedRepository).union(Set(repositories.items)))
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
    
}
