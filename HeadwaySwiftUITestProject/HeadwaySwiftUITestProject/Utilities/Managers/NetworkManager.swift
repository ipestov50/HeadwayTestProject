//  SearchRepositories.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 07.06.2022.
//

import SwiftUI

 class NetworkManager: ObservableObject {
    
    static let shared = NetworkManager()
    
    // Sort by stars
    private let sort = "stars"
    
    func find(query: String, page: Int, completion: @escaping (Result<[Repository]?, NetworkError>) -> Void) {
        // removing spaces
        let searchQuery = query.replacingOccurrences(of: " ", with: "%20")
        
        let url = "https://api.github.com/search/repositories?q=\(searchQuery)&per_page=30&sort=\(sort)&page=\(page)&order=desc&since=daily"
        let session = URLSession(configuration: .default)
        
        
        
        session.dataTask(with: URL(string: url)!) { data, response, error in
            
            guard let url = URL(string: url) else {
                completion(.failure(.invalidURL))
                return
            }
            
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let jsonData = data else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
                
            do {
                let repositories = try JSONDecoder().decode(Results.self, from: jsonData)
                // appending to searched Repositories...
                DispatchQueue.main.async {
                    // checking if any data already loaded is again loaded...
                    // ignores already loaded
                    completion(.success(repositories.items))
                }
            } catch {
                print(error)
                
                DispatchQueue.main.async {
                    completion(.failure(.invalidData))
                }
            }
        }
        .resume()
    }
    
}
