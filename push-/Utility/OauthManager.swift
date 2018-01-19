import Foundation
import Alamofire


class OauthManager {
    
    static func getToken(code: String, completion: @escaping (String) -> Swift.Void) {
        
        let urlString = "https://github.com/login/oauth/access_token"
        let request = NSMutableURLRequest(url: URL(string: urlString)!)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let params: [String: Any] = [
            "client_id": Config.client_id,
            "client_secret": Config.client_secret,
            "code": code
        ]
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data,response,error) -> Void in
            
            let resultData = String(data: data!, encoding: .utf8)!
            print("result:\(resultData)")
            if resultData.prefix(7) == "access_" {
            let token = resultData.split(separator: "=")[1].split(separator: "&")[0]
                  completion(String(token))
            } else {
                 completion("")
            }
        })
        task.resume()
    }
}

//aaa.split(separator: "=")[1].split(separator: "&")[0]



