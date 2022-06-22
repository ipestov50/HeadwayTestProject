//  SearchRepositories.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 07.06.2022.
//

import SwiftUI

class APIService: ObservableObject {
    
    // Sort by stars
    private let sort = "stars"
    
    func find(query: String, page: Int, completion: @escaping ([Repository]?) -> (Void) ) {
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
                    // checking if any data already loaded is again loaded...
                    // ignores already loaded
                    
                    completion(repositories.items)
                }
            } catch {
                print(error)
                
                DispatchQueue.main.async {
                    completion(nil)
                }
                
            }
        }
        .resume()
    }
    
}
