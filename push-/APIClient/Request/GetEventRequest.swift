import Foundation
import Alamofire

struct Entry {
    
    var icon: String
    var name: String
    var title: String
    
    static func decode(_ object: Any) ->  Repository {
        
        guard let dic = object as? [String: Any] else {
            fatalError("@: unexpected format")
        }
        
        guard let name = dic["name"] as? String,
            let star = dic["stargazers_count"] as? Int,
            let  fork = dic["forks_count"] as? Int else {
                fatalError("@: missing value")
        }
        
        return Repository(name: name, star: star, fork: fork)
    }
    
    static func map(_ object: Any) ->  [Repository] {
        
        guard let ary = object as? [Any] else {
            fatalError("@: unexpected format")
        }
        return ary.map { Repository.decode($0) }
    }
}



enum ActivityEventTarget {
    case news
    case user
}

struct GetEventRequest: GithubRequestType {
    
    public typealias ResponseType = [Event]
    
    private var type: ActivityEventTarget
    init(_ type: ActivityEventTarget) {
        self.type = type
    }
    public var method: HTTPMethod {
        return .get
    }
    
    public var path: String {
        
        switch type {
        case .news: return "/users/churabou/received_events"
        case .user: return "/users/churabou/events"
        }
    }

    public func responseFromObject(_ object: Any) -> ResponseType? {
        return Event.map(object)
    }
}




