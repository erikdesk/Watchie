import Foundation

struct FetchL1Movie: Decodable {
    
    var genreIds: [Int]
    
    var id: Int
    var title: String
    var overview: String
    var status: String
    
    var popularity: Float
    var budget: Float
    var revenue: Float
    var voteAverage: Float
    var voteCount: Float

    var releaseDate: Date?
    var posterId: String?
    
    init(from decoder: Decoder) throws {
        let rawResponse = try RawServerResponse(from: decoder)
        
        genreIds = rawResponse.genres.map { $0.id }
        
        id = rawResponse.id
        title = rawResponse.title
        overview = rawResponse.overview
        status = rawResponse.status
        
        popularity = rawResponse.popularity
        budget = rawResponse.budget
        revenue = rawResponse.revenue
        voteAverage = rawResponse.vote_average
        voteCount = rawResponse.vote_count

        releaseDate = rawResponseDateTextToSwiftDate(from: rawResponse.release_date, format: "yyyy-MM-dd")
        posterId = rawResponsePosterPathTextToId(from: rawResponse.poster_path)
    }
    
    func show() {
        for property in Mirror(reflecting: self).children {
            print(property.value)
        }
    }
}

fileprivate struct RawServerResponse: Decodable {
    
    var genres: [FetchL1Genre]
    
    var id: Int
    var title: String
    var overview: String
    var status: String
    
    var popularity: Float
    var budget: Float
    var revenue: Float
    var vote_average: Float
    var vote_count: Float
    
    var release_date: String?
    var poster_path: String?
    
    var homepage: String?
    var imdb_id: String?
    var original_language: String?
    var original_title: String?

    // Unused:
    //adult
    //backdrop_path
    //
    //
    //belongs_to_collection // obj
    //    id
    //    name
    //    poster_path
    //    backdrop_path
    //
    //
    //genres [ // array of obj
    //    id
    //    name
    //]
    //
    //
    //production_companies [ // array of obj
    //    id
    //    logo_path
    //    name
    //    origin_country
    //]
    //
    //production_countries [ // array of obj
    //    iso_3166_1
    //    name
    //]
    //
    //runtime
    //
    //spoken_languages [ // array of obj
    //    english_name
    //    iso_639_1
    //    name
    //]
    //
    //tagline
    //video
        
    // Not yet implemented: havent added the rest of &append_to_response=
    //    images,
    //    videos,
    //    keywords,
    //    credits,
    //    release_dates,
    //    watch/providers
}
