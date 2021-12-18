import UIKit
import CoreData

struct CoreDataAPI {
    
    static var shared = CoreDataAPI()
    
    private init() { }

    func fetchFromCoreData() -> [MovieTag] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        do {
            let movieCoreDatas = try context.fetch(MovieCoreData12.fetchRequest())
            var movieTags: [MovieTag] = []
            
            for movieCoreData in movieCoreDatas { //} as! [MovieCoreData] {
                movieTags.append(MovieTag(id: Int(movieCoreData.id),
                          //name: movieCoreData.name!,
                          //posterId: movieCoreData.posterId!,
                          //posterImage: nil,
                          //releaseDate: movieCoreData.releaseDate!,
                          group: movieCoreData.group!,
                          watchedDate: movieCoreData.watchedDate))
            }
            return movieTags
        } catch {
            return []
        }
    }
    
    func addOrReplaceToCoreData(id: Int, group: String, watchedDate: Date?) {
        
        do {
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let request = MovieCoreData12.fetchRequest() as NSFetchRequest<MovieCoreData12>
            let pred = NSPredicate(format: "id == %d", id)
            request.predicate = pred
            let results = try context.fetch(request)
            
            // MARK: if movie id is in the table then REPLACE record
            if results.count != 0 {
                //print("\(results[0].id) - DELETED")
                context.delete(results[0])
                try context.save()
            }
            
            // MARK: if movie id is NOT in the table then ADD record
            let movieCoreDataToAdd = MovieCoreData12(context: context)
//            if (tag == "Watched") && (watchedDate == nil) {
//                var randomWatchedDateString: String
//                randomWatchedDateString = "2021-\(String(format: "%02d", Int.random(in: 1...5)))-01"
////                print(randomWatchedDateString)
//
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateStyle = DateFormatter.Style.long
//                dateFormatter.dateFormat = "yyyy-MM-dd"
//                let randomWatchedDate = dateFormatter.date(from: randomWatchedDateString)
//                movieCoreDataToAdd.watchedDate = randomWatchedDate
////                print(randomWatchedDate)
//            } else {
                movieCoreDataToAdd.watchedDate = watchedDate
//            }
            movieCoreDataToAdd.id = Int64(id)
            movieCoreDataToAdd.group = group
            
//            print(movieCoreDataToAdd)
            //print("\(movieCoreDataToAdd.id) - ADDED")
            try context.save()
            
        } catch {
            //print("🥲🔥")
        }
    }
    
}
