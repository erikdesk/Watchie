import UIKit

struct FetchAPI {
    static var shared = FetchAPI()
    private var dataTask: URLSessionDataTask?
    
    private init() {}
    
    mutating func fetchData<T: Decodable>(from url: URL, withCancelDataTask isCancelDataTask: Bool, completion: @escaping (Result<T, Error>) -> Void) {
        if isCancelDataTask {
            dataTask?.cancel()
        }
        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(NetworkError.client(message: "Fetch Data API client error.")))
                return
            }
            guard let res = response as? HTTPURLResponse, (200...299).contains(res.statusCode) else {
                completion(.failure(NetworkError.server(message: "Fetch Data API server error.")))
                return
            }
            do {
                guard let data = data else {
                    completion(.failure(NetworkError.client(message: "Fetch Data API client error.")))
                    return
                }
                let decodable = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodable))
            } catch {
                completion(.failure(NetworkError.client(message: error.localizedDescription)))
            }
        }
        dataTask?.resume()
    }
    
    mutating func fetchImage(from url: URL, withCancelDataTask isCancelDataTask: Bool, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if isCancelDataTask {
            dataTask?.cancel()
        }
        dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                completion(.failure(NetworkError.client(message: "Fetch Image API client error.")))
                return
            }
            guard let res = response as? HTTPURLResponse, (200...299).contains(res.statusCode) else {
                completion(.failure(NetworkError.server(message: "Fetch Image API server error.")))
                return
            }
            if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            } else if let error = error {
                completion(.failure(NetworkError.client(message: error.localizedDescription)))
            } else {
                completion(.failure(NetworkError.imageDataMissing(message: "Fetch Image API image missing error.")))
            }
        }
        dataTask?.resume()
    }
    
    mutating func fetchBatchData<T: Decodable>(from urls: [URL], withCancelDataTask isCancelDataTask: Bool, completion: @escaping (Result<[T], Error>) -> Void) {
        
        let group = DispatchGroup()
        var items: [T] = []
        var errorCount = 0
        
        for url in urls {
            group.enter()
            fetchData(from: url, withCancelDataTask: false) { (result: Result<T, Error>) in
                switch result {
                case .success(let item):
                    items.append(item)
                case .failure(let error):
                    print(error)
                    errorCount += 1
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            if errorCount == 0 {
                completion(.success(items))
            } else {
                completion(.failure(NetworkError.batchDataError(message: "Fetch Batch Data API error.")))
            }
        }
    }
    
    mutating func fetchBatchImage(withImageIds imageIds: [String], withCancelDataTask isCancelDataTask: Bool, completion: @escaping (Result<[Image], Error>) -> Void) {
        
        let group = DispatchGroup()
        var items: [Image] = []
        var errorCount = 0
        
        for id in imageIds {
            group.enter()
            let url = URL(string: "https://image.tmdb.org/t/p/w500/\(id).jpg")!
            fetchImage(from: url, withCancelDataTask: false) { (result: Result<UIImage, Error>) in
                switch result {
                case .success(let item):
                    items.append(Image(id: id, image: item))
                case .failure(let error):
                    print(error)
                    errorCount += 1
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            if errorCount == 0 {
                completion(.success(items))
            } else {
                completion(.failure(NetworkError.batchImageError(message: "Fetch Batch Image API error.")))
            }
        }
    }
    
//    mutating func fetchBatchImage(from urls: [URL], withCancelDataTask isCancelDataTask: Bool, completion: @escaping (Result<[UIImage], Error>) -> Void) {
//
//        let group = DispatchGroup()
//        var items: [UIImage] = []
//        var errorCount = 0
//
//        for url in urls {
//            group.enter()
//            fetchImage(from: url, withCancelDataTask: false) { (result: Result<UIImage, Error>) in
//                switch result {
//                case .success(let item):
//                    items.append(item)
//                case .failure(let error):
//                    print(error)
//                    errorCount += 1
//                }
//                group.leave()
//            }
//        }
//        group.notify(queue: .main) {
//            if errorCount == 0 {
//                completion(.success(items))
//            } else {
//                completion(.failure(NetworkError.batchImageError(message: "Fetch Batch Image API error.")))
//            }
//        }
//    }
    
    enum NetworkError: Error {
        case client(message: String)
        case server(message: String)
        case imageDataMissing(message: String)
        
        case batchDataError(message: String)
        case batchImageError(message: String)
    }
}
