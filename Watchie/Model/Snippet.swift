import UIKit

struct Snippet: Decodable, Hashable {
    
//    var genreIds: [Int]
    
    var id: Int
    var title: String
    var overview: String
    
    var popularity: Float
    var voteAverage: Float
    var voteCount: Float
    
    var releaseDate: Date?
    var posterId: String?
    
    var posterImage: UIImage? // added in a later fetch poster step.
    
    
    init(from decoder: Decoder) throws {
        let rawResponse = try RawServerResponse(from: decoder)
        
//        genreIds = rawResponse.genre_ids
        
        id = rawResponse.id
        title = rawResponse.title
        overview = rawResponse.overview
        
        popularity = rawResponse.popularity
        voteAverage = rawResponse.vote_average
        voteCount = rawResponse.vote_count

        releaseDate = rawResponseDateTextToSwiftDate(from: rawResponse.release_date, format: "yyyy-MM-dd")
        posterId = rawResponsePosterPathTextToId(from: rawResponse.poster_path)
    }
}
    
fileprivate struct RawServerResponse: Decodable {
    
//    var genre_ids: [Int]
    
    var id: Int
    var title: String
    var overview: String
    
    var popularity: Float
    var vote_average: Float
    var vote_count: Float
    
    var release_date: String?
    var poster_path: String?
    
    // Unused:
    // adult: false,
    // backdrop_path: "/qdZpvTrr4J7mMAIF0Iv8E5on50G.jpg",
    // original_language: "en",
    // original_title: "Spider-Man Strikes Back",
    // video: false,
}
