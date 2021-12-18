import Foundation

struct FetchSnippetSearchMovieSinglePage: Decodable {
    var items: [Snippet]
    
    var totalPages: Int
    var totalItems: Int
    var page: Int
    
    init(from decoder: Decoder) throws {
        let rawResponse = try RawServerResponse(from: decoder)
        
        items = rawResponse.results
        
        totalItems = rawResponse.total_results
        totalPages = rawResponse.total_pages
        page = rawResponse.page
    }
    
    func show() {
        for property in Mirror(reflecting: self).children {
            print(property.value)
        }
    }
}

fileprivate struct RawServerResponse: Decodable {
    
    var results: [Snippet]
    
    var total_results: Int
    var total_pages: Int
    var page: Int
}
