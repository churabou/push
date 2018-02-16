import Foundation
import Alamofire
import SwiftyJSON

struct Repository {
    var name: String
    var star: Int
    var fork: Int

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



struct GetRepositoryRequest: GithubRequestType {
    
    public typealias ResponseType = [Repository]
    
    public var method: HTTPMethod {
        return .get
    }

    public var path: String {
        return "/user/repos"
    }
    
    public func responseFromObject(_ object: Any) -> ResponseType? {
        return Repository.map(object)
    }
}



