import Foundation
import Alamofire
import SwiftyJSON

protocol ActivityViewModelDelegate {
    func didFetchFeeds(_ feeds: [Activity])
}

class ActivityViewModel {
    
    var delegate: ActivityViewModelDelegate?
    
    var feeds: [Activity] = []
    var isLoadImage = false
    
    enum FeedViewState {
        case requestReady
        case requestSuccess(feeds: [Activity])
        case requestFailed
        case loadImage
        case none
    }
    
    var state: FeedViewState = .none {
        
        didSet {
            switch state {
            case .requestReady:
                fetchFeeds()
            case .requestSuccess(let feeds):
                self.feeds = feeds
                delegate?.didFetchFeeds(feeds)
            default:
                return
            }
        }
    }
    
    func fetchFeeds(){

        let request = GetFeedRequest()
        APIClient.shared.send(request: request, completion: { (response) in
            
            switch response {
            case .success(_, let feed):
                let p = AtomParcer()
                p.parseXML(feed.timelineUrl)
                self.state = .requestSuccess(feeds: p.feeds)
            case .failure(_, let message):
                print("failed \(message)")
            }
        })
    }
}
