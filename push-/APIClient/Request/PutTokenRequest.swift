import Foundation
import Alamofire

//struct Entry {
//
//    var token: String
//
//    static func decode(_ object: Any) ->  Repository {
//
//        guard let dic = object as? [String: Any] else {
//            fatalError("@: unexpected format")
//        }
//
//        guard let token = dic["hashed_token"] as? String else {
//                fatalError("@: missing value")
//        }
//
//        return Repository(name: name, star: star, fork: fork)
//    }
//}



struct GetTokenRequest: GithubRequestType {
    
    public typealias ResponseType = String
    
    var code: String
    
    init(code: String) {
        self.code = code
    }
    
    public var method: HTTPMethod {
        return .put
    }
    
    public var path: String {
        return "/authorizations/clients/\(Config.client_id)"
    }
    
    public var parameters: [String : String]? {
        
        let params: [String: String] = [
            "client_secret": Config.client_secret,
            "fingerprint": code
        ]
        
        return params
    }
    
    public func responseFromObject(_ object: Any) -> ResponseType? {
        //        return Repository.map(object)
        print(object)
        print("カキクケコ")
        guard let dic = object as? [String: Any] else {
            fatalError("unexpected format")
        }
        
        guard let token = dic["hased_token"] else {
            fatalError("missing value")
        }
        print("成功")
        return nil
//        return token as! GetTokenRequest.ResponseType
    }
}





