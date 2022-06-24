
import SwiftUI

struct Repository: Identifiable, Codable, Hashable {
    
    var id: Int
    var node_id: String?
    var name: String?
    var html_url: String?
    var description: String?
    var visibility: String? 
    var language: String?
    var updated_at: String?
    var login: String?
    
    
    
    var isLiked: Bool?
    var isSeen: Bool? 
}

struct Results: Codable {
    var items: [Repository]?
}

