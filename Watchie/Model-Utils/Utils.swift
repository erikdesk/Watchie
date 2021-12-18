import Foundation

func rawResponseDateTextToSwiftDate(from rawResponseDateText: String?, format rawResponseDateFormat: String) -> Date? {
    var date: Date?
    
    if let releaseDateString = rawResponseDateText {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.long
        dateFormatter.dateFormat = rawResponseDateFormat
        date = dateFormatter.date(from: releaseDateString)
        return date
        
    } else {
        return nil
        
    }
}

func rawResponsePosterPathTextToId(from rawResponsePosterPathText: String?) -> String? {
    if var posterPathString = rawResponsePosterPathText {
        posterPathString = posterPathString.replacingOccurrences(of: "/", with: "")
        posterPathString = posterPathString.replacingOccurrences(of: ".jpg", with: "")
        return posterPathString
        
    } else {
        return nil
    }
}
