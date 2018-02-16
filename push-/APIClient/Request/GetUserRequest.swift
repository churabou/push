import Foundation
import Alamofire


struct User {
    var name: String = ""
    var iconURL: String = ""
    
    static func decode(_ object: Any) -> User {
        
        guard let dic = object as? [String: Any] else {
            fatalError("unexpected type")
        }
        
        guard  let name = dic["login"] as? String,
            let iconURL = dic["avatar_url"] as? String else {
                fatalError("missing value")
        }
        
        return User(name: name, iconURL: iconURL)
    }
}

//https://developer.github.com/v3/users/
struct GetUserRequest: GithubRequestType {
    
    public typealias ResponseType = User
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var path: String {
        return "/user"
    }
    
    public func responseFromObject(_ object: Any) -> ResponseType? {
        return User.decode(object)
    }
}



