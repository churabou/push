import Foundation
import Alamofire
import SwiftyJSON


class ActivityViewModel {
    

    var activities: [Activity] = [] {
        didSet {
            activitiesDidSet?(activities)
        }
    }

    var error = "" {
        didSet {
            errorDidSet?(error)
        }
    }
    
    var isLoading = false {
        didSet {
            isLoadingDidSet?(isLoading)
        }
    }
    
    //MARK: Events
    var isLoadingDidSet:((Bool) -> Swift.Void)?
    var activitiesDidSet: (([Activity]) -> Swift.Void)?
    var errorDidSet: ((String) -> Swift.Void)?
    
    
    //MARK: Action

    func fetchActivities(){
        self.isLoading = true
        let request = GetFeedRequest()
        APIClient.shared.send(request: request, completion: { (response) in
            
            switch response {
            case .success(_, let feed):
                self.isLoading = false
                let p = AtomParcer()
                p.parseXML(feed.timelineUrl)
                self.activities = p.feeds
            case .failure(_, let message):
                self.isLoading = false
                print("failed \(message)")
            }
        })
    }
}
