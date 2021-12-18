import Foundation

struct FetchSnippet {
    static var shared = FetchSnippet()
    
    func fromIds(withIds ids: [Int], completion: @escaping (Result<[Snippet], Error>) -> Void) {
        
        //print("**")
        //print(ids)
        
        let urls = ids.map {
            URL(string: "https://api.themoviedb.org/3/movie/" + String($0) + "?api_key=abf690bbe6b0f182815420cfe570a539")!
        }
        
        //print(urls)
        FetchAPI.shared.fetchBatchData(from: urls, withCancelDataTask: false) { (result: Result<[Snippet], Error>) in
//            var items: [Snippet] = []
            switch result {
                case .success(let items):
//                    items.append(contentsOf: page.items)
//                    for pagex in pages {
//                        items.append(contentsOf: pagex.items)
//                    }
                    completion(.success(items))
                case .failure(let error):
                    print(error)
            }
        }
        
        
//        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=abf690bbe6b0f182815420cfe570a539&query=" + query)!
        
//        FetchAPI.shared.fetchData(from: url, withCancelDataTask: false, completion: { (result: Result<FetchSnippetSearchMovieSinglePage, Error>) in
//            switch result {
//                case .success(let page):
//                    if page.totalPages > 1 {
//
//                        let pages = Array(2...page.totalPages)
//                        let urls = pages.map { URL(string: url.absoluteString + "&page=" + String($0))! }
//

//
//                    } else {
//                        completion(.success(page.items))
//                    }
//                case .failure(let error):
//                    print(error)
//            }
//        })
    }
    
    func searchMovie(withQuery query: String, completion: @escaping (Result<[Snippet], Error>) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=abf690bbe6b0f182815420cfe570a539&query=" + query)!
        
        FetchAPI.shared.fetchData(from: url, withCancelDataTask: false, completion: { (result: Result<FetchSnippetSearchMovieSinglePage, Error>) in
            switch result {
                case .success(let page):
                    if page.totalPages > 1 {
                        
                        let pages = Array(2...page.totalPages)
                        let urls = pages.map { URL(string: url.absoluteString + "&page=" + String($0))! }
                        
                        FetchAPI.shared.fetchBatchData(from: urls, withCancelDataTask: false) { (result: Result<[FetchSnippetSearchMovieSinglePage], Error>) in
                            var items: [Snippet] = []
                            switch result {
                                case .success(let pages):
                                    items.append(contentsOf: page.items)
                                    for pagex in pages {
                                        items.append(contentsOf: pagex.items)
                                    }
                                    completion(.success(items))
                                case .failure(let error):
                                    print(error)
                            }
                        }
                        
                    } else {
                        completion(.success(page.items))
                    }
                case .failure(let error):
                    print(error)
            }
        })
    }
}
