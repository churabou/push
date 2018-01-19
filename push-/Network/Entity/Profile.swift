import Foundation
import SwiftyJSON

struct Profile: Codable {
    
    var name = ""
    var iconURL = ""
    
    init(_ name: String, _ iconURL: String) {
        self.name = name
        self.iconURL = iconURL
    }
    
    init(json: JSON) {
        self.name = json["login"].string!
        self.iconURL = json["avatar_url"].string!
    }
}

