//import UIKit
//
//struct Fetch {//}: Decodable {
//
//
////    init(from decoder: Decoder) throws {
////        let rawResponse = try RawServerResponse(from: decoder)
////
////        items = rawResponse.results
////    }
//
//    //static func searchMovies(withGenreName genreName: String?, completion: @escaping (Result<[MovieFetched], Error>) -> Void) {
//    mutating func searchMovies(withQuery query: String, completion: @escaping (Result<[MovieSnippet], Error>) -> Void) {
//
//        getItemsFromAllPages(withQuery: query) { (result: Result<[MovieSnippet], Error>) in
//
//        }
//
//
//        
////        let pages = Array(1...1)
////
////        let maxTotalPagesLimit = 4
////        var page = 1
////
////        
////        FetchAPI.shared.fetchData(from: url, withCancelDataTask: true) { (result: Result<FetchSearchItemsOnePage, Error>) in // is [weak self] needed here?
////            print("fetched.." + query)
////            switch result {
////                case .success(let x):
////                    print(x.items.count)
////                case .failure(let error):
////                    print(error)
////            }
////        }
//    }
//
////    var items: [MovieSnippet] = []
//    var items: [MovieSnippet] = []
//
//    mutating func getItemsFromAllPages(withQuery query: String, completion: @escaping (Result<[MovieSnippet], Error>) -> Void) {
////        var items: [MovieSnippet] = []
//        getItemsFromAllPagesHelper(withQuery: query, withPage: 1) { (result: Result<[MovieSnippet], Error>) in
//            //print("HELLO")
//        }
//    }
////    _ itemsSoFar: inout [MovieSnippet],
//    mutating func getItemsFromAllPagesHelper(withQuery query: String, withPage page: Int, completion: @escaping (Result<[MovieSnippet], Error>) -> Void) {
//
//        let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=abf690bbe6b0f182815420cfe570a539&query=" + query + "&page=" + String(page))!
//
//        FetchAPI.shared.fetchData(from: url, withCancelDataTask: true) { (result: Result<FetchSearchItemsOnePage, Error>) in
//            switch result {
//            case .success(let x):
//                if x.page < x.totalPages {
//                    getItemsFromAllPagesHelper(withQuery: query, withPage: x.page + 1) { (result: Result<[MovieSnippet], Error>) in
//                        switch result {
//                        case .success(let x):
//                            print("x")
//                        case.failure:
//                            print("a")
//                        }
//
//                    }
//                } else {
//                    completion(.success([]))
//                }
//            case.failure:
//                print("a")
//            }
//        }
////        FetchAPI.shared.fetchData(from: url, withCancelDataTask: true) { (result: Result<FetchSearchItemsOnePage, Error>) in // is [weak self] needed here?
////            switch result {
////                case .success(let x):
//////                self.items += x.items
////                    if x.page < x.totalPages {
////                        // &itemsSoFar,
////                        getItemsFromAllPagesHelper(withQuery: query, withPage: x.page + 1) { (result: Result<[MovieSnippet], Error>) in
////
////                        }
////                    } else {
////                        //let decodable = try JSONDecoder().decode(T.self, from: data)
////                        completion(.success([])) // self.items
////                    }
////            case .failure:
////                completion(.failure(NetworkError.server(message: "Page fetch error.")))
////                return
////            }
////        }
//    }
//
////    mutating func getPages<T: Decodable>(withQuery query: String, withPage page: Int, completion: @escaping (Result<T, Error>) -> Void) {
////
////
////        do {
////            //guard let data = data else {
////            //    completion(.failure(NetworkError.client(message: "Fetch Data API client error.")))
////            //    return
////            //}
////            //
////            //
////        } catch {
////            //completion(.failure(NetworkError.client(message: error.localizedDescription)))
////        }
////    }
//
//   enum NetworkError: Error {
//       case client(message: String)
//       case server(message: String)
//       case imageDataMissing(message: String)
//   }
//}
//
////fileprivate func getPages(onCompleted handler: @escaping () -> Void) {
////   loadResults { pageReturned in
////      let needToLoadMore = ... // determine if you need to load more pages
////      // other side effects
////
////      if needToLoadMore {
////          getPages(onCompleted: handler)
////      } else {
////         handler()
////      }
////   }
////}
//
//fileprivate struct RawServerResponse: Decodable {
//
//    var results: [MovieSnippet]
//}
