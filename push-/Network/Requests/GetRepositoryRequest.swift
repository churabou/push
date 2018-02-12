import Foundation
import Alamofire
import SwiftyJSON


struct Repository {
    var name = ""
}

struct GetRepositoryRequest: APIClientRequestType {
    
    public typealias ResponseType = Repository
    
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
        let headers: HTTPHeaders = ["Authorization": "token \(Config.token)"]
        return headers
    }
    
    public func responseFromObject(_ object: Any) -> ResponseType? {
        return nil
//        let json = JSON(object)
//        guard let model = ResponseType.decode(json: json) else {
//            return nil
//        }
//        return model
    }
}


