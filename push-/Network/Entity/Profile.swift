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
    
    static func parce(json: JSON) -> Profile? {
        guard let name = json["login"].string, let iconURL = json["avatar_url"].string else {
            return nil
        }
        
        return Profile(name, iconURL)
    }
}

