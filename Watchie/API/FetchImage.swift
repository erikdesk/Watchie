import UIKit

struct FetchImage {
    static var shared = FetchImage()

    func fetchImage(withImageIds imageIds: [String], completion: @escaping (Result<[Image], Error>) -> Void) {
        FetchAPI.shared.fetchBatchImage(withImageIds: imageIds, withCancelDataTask: false) { (result: Result<[Image], Error>) in
            switch result {
                case .success(let images):
                    completion(.success(images))
                case .failure(let error):
                    print(error)
            }
        }
    }
}
