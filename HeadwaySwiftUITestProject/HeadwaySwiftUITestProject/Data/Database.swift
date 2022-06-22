//
//  Database.swift
//  SwiftUITestProject
//
//  Created by Ivan Pestov on 09.06.2022.
//

import Foundation
import SwiftUI

final class Database {
    private let FAV_KEY = "fav_key"
    public static let shared = Database()
    
    private init() {
        
    }
    
    @discardableResult // 
    func create(item: Repository) -> [Repository] {
        if let data = try? JSONEncoder().encode(item) { // item -> data
            var array: [Data] = UserDefaults.standard.array(forKey: FAV_KEY) as? [Data] ?? [] // get array of data from storage
            array.append(data) // save a new data to array of data
            UserDefaults.standard.set(array, forKey: FAV_KEY) // save array of data into the storage
        }
        return read()
    }
    
    func read() -> Array<Repository> {
        let array = UserDefaults.standard.array(forKey: FAV_KEY) as? [Data] ?? [Data]()
        
        var repositories = [Repository]()
        let decoder = JSONDecoder()
        
        for data in array {
            if let repository = try? decoder.decode(Repository.self, from: data) {
                repositories.append(repository)
            }
        }
        return repositories
    }
    
    func delete(item: Repository) -> [Repository] {
        var saved = read()
        
        saved.removeAll { $0 == item }
        
        UserDefaults.standard.set([], forKey: FAV_KEY)
        
        for item in saved {
            create(item: item)
        }
        return saved
    }
}
