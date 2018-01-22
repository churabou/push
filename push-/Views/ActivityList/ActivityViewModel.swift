import Foundation
import Alamofire
import SwiftyJSON

protocol ActivityViewModelDelegate {
    func didFetchFeeds(_ feeds: [Feed])
}

class ActivityViewModel {
    
    var delegate: ActivityViewModelDelegate?
    
    var feeds: [Feed] = []
    var isLoadImage = false
    
    enum FeedViewState {
        case requestReady
        case requestSuccess(feeds: [Feed])
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
        
        APIClient.shared.fetchFeedsRequest({ (feeds) in
            self.state = .requestSuccess(feeds: feeds)
        })
    }
}
