import Foundation
import SwiftyJSON

struct Feed {
    
    var timelineUrl = ""
//    var currentUserPublic = ""
//    var
    
    static func decode(json: JSON) -> Feed? {
        guard let timelineUrl = json["timeline_url"].string else {
            return nil
        }
        
        print("@@")
        print(json)
        return Feed(timelineUrl: timelineUrl)
    }
}

