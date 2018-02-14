import Foundation
import Alamofire
import SwiftyJSON


struct Repository {
    var name: String
    var star: Int
    var fork: Int
    
    static func decode(_ object: Any) -> Repository? {
        
        guard let dic = object as? [String: Any] else {
            return nil
        }
        
        if let name = dic["name"] as? String,
            let star = dic["stargazers_count"] as? Int,
            let fork = dic["forks_count"] as? Int {
            return Repository(name: name, star: star, fork: fork)
        } else {
            return nil
        }
    }
}

struct GetRepositoryRequest: APIClientRequestType {
    
    public typealias ResponseType = [Repository]
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var baseURL: String {
        return "https://api.github.com"
    }
    
    public var path: String {
        return "/user/repos"
    }
    
    public var headers: HTTPHeaders {
        let headers: HTTPHeaders = ["Authorization": "token \(Config.token)", "Content-type": "application/json"]
        return headers
    }
    
    public func responseFromObject(_ object: Any) -> ResponseType? {

        if let ary = object as? [Any] {
            return ary.map { Repository.decode($0)! }
        } else {
            return nil
        }
    }
}


