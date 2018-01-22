import Foundation
import SwiftyJSON

struct Feed {
    
    var timelineUrl = ""
    
    static func decode(json: JSON) -> Feed? {
        guard let timelineUrl = json["timeline_url"].string else {
            return nil
        }
        
        return Feed(timelineUrl: timelineUrl)
    }
}

