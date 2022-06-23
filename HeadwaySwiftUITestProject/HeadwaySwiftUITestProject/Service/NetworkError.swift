//
//  NetworkError.swift
//  HeadwaySwiftUITestProject
//
//  Created by Ivan Pestov on 23.06.2022.
//

import Foundation

enum NetworkError: Error {
    
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}
