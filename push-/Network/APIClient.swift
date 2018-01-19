import Foundation
import Alamofire
import SwiftyJSON

struct Network {
    
    static let shared = Network()
    
    func request(_ url: URL) {
        
    }
    
}


class APIClient {
    
    static let shared = APIClient()
    
    func fetchProfileRequest(_ completion: @escaping (Profile) -> Swift.Void) {
        
        let url = "https://api.github.com/user?access_token=\(Config.token)"
        
        Alamofire.request(url).responseJSON { result in
            
            guard let json = result.result.value else { return }
            let profile = Profile(json: JSON(json))
            completion(profile)
        }
    }
    
    func fetchFeedsRequest(_ completion: @escaping ([Feed]) -> Swift.Void) {
        
        let token = "10fd9d253d27f90ffc35dbd69ab20580a36df62c"
        let url = "https://api.github.com/feeds?access_token=\(token)"
        
        Alamofire.request(url).responseJSON { response in
            
            guard let json = response.result.value else { return }
            guard let timeLineURL = JSON(json)["timeline_url"].string else { return }
            
            let p = AtomParcer()
            p.parseXML(timeLineURL)
            completion(p.feeds)
        }
    }
}
