
import SwiftUI

struct Repository: Identifiable, Decodable, Hashable {
    
    var id: Int
    var node_id: String
    var name: String
    var html_url: String
    var description: String
    
    static var sampleItems: [Repository] {
        var tempList = [Repository]()
        
        
        for i in 1...10 {
            let id = i
            let node_id = ""
            let name = "Name \(i)"
            let description = "This is a sample description."
            let html_url = "html_url \(i)"
            
            tempList.append(Repository(id: id, node_id: node_id, name: name, html_url: html_url, description: description))
        }
        return tempList
    }
}

struct Results: Decodable {
    var items: [Repository]
}
