import Foundation
import Alamofire
import SwiftyJSON


struct GetProfileRequest: APIClientRequestType {
    
    public typealias ResponseType = Profile
    

    public var method: HTTPMethod {
        return .post
    }
    
    public var baseURL: String {
        return "https://api.github.com"
    }
    
    public var path: String {
        return "/user"
    }
    
    /*
     X-Client-Signature: { value }
     value=POSTボディ (applicaiton/x-www-formurlencoded 済み)を、shared secret をキーにして生成したHMAC-SHA256 ダイジェスト値
     */
    public var headers: HTTPHeaders {
        var headers: HTTPHeaders = [:]
        return headers
    }
    
    var parameters: [String: String]? {
        var param: [String: String] = [:]
        param["access_token"] = Config.token
        return param
    }
    
    public func responseFromObject(_ object: Any) -> ResponseType? {
        guard let model = ResponseType.parce(json: object as! JSON) else {
            return nil
        }
        return model
    }
}

