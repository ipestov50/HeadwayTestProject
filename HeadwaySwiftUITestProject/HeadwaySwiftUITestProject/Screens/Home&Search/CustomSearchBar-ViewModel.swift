//
//  CustomSearchBar-ViewModel.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 09.06.2022.
//

import Foundation
import SwiftUI

final class ViewModel: ObservableObject {
    
    @Published var data = [RepositoryUI]() // репозитории от сервера
    @Published var query = ""
    @Published var alertItem: AlertItem?
    
    struct RepositoryUI: Identifiable, Codable, Hashable {
        var id: Int {
            repository.id
        }
        var repository: Repository
        var isLiked: Bool
    }
    
    private var page = 1
    
    var networkManager = NetworkManager()
    
    private var db = Database.shared
    
    init() {
        
    }
    
    func toggleFav(item: Repository) {
        if db.read().contains(item) {
           let newLiked = db.delete(item: item)
            self.data = updateData(data.map { $0.repository } , newLiked)
        } else {
            let newLiked = db.create(item: item)
            self.data = updateData(data.map { $0.repository }, newLiked)
        }
        
    }
    
    func onChange(query: String) {
        let liked = db.read()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            
            print("search")
            
            if query != "" {
                // searcing Repository...
                self.page = 1
                self.networkManager.find(query: query, page: self.page, completion: { repositories in
                    
                        switch repositories {
                        case .success(let repositories):
                            self.data = self.updateData(repositories ?? [], liked)
                            
                        case .failure(let error):
                            switch repositories {
                            case .success(let repositories):
                                self.data += self.updateData(repositories ?? [], liked)
                                
                            case .failure(let error):
                                switch error {
                                case .invalidURL:
                                    self.alertItem = AlertContext.invalidURL
                                    
                                case .invalidResponse:
                                    self.alertItem = AlertContext.invalidResponse
                                    
                                case .invalidData:
                                    self.alertItem = AlertContext.invalidData
                                    
                                case .unableToComplete:
                                    self.alertItem = AlertContext.unableToComplete
                                    
                                }
                            }
                        }
                    
                })
            } else {
                // removing all searched Data...
                self.data.removeAll()
            }
        }
    }
    
    func onAppear(repository: Repository) {
        let liked = db.read()
        if repository.node_id == data.last?.repository.node_id && page <= 3 {
            page += 1
            self.networkManager.find(query: query, page: self.page, completion: { [self] repositories in
                
                DispatchQueue.main.async {
                    switch repositories {
                    case .success(let repositories):
                        self.data += self.updateData(repositories ?? [], liked)
                        
                    case .failure(let error):
                        switch error {
                        case .invalidURL:
                            self.alertItem = AlertContext.invalidURL
                            
                        case .invalidResponse:
                            self.alertItem = AlertContext.invalidResponse
                            
                        case .invalidData:
                            self.alertItem = AlertContext.invalidData
                            
                        case .unableToComplete:
                            self.alertItem = AlertContext.unableToComplete
                            
                        }
                    }
                }
            })
        }
    }
    
    func updateData(_ repositories: [Repository], _ liked: [Repository]) -> [RepositoryUI] {
        var data = [RepositoryUI]()
        for repository in (repositories) {
            data.append(RepositoryUI.init(repository: repository, isLiked: liked.contains(repository)))
        }
        return data
    }
}




// TODO

// 54 строка
// 68 строка

// после запроса репозиториев найти в сохраненных репозиториях те которые пришли от сервера и если они там содержатся выставить им параметр isLike = true

