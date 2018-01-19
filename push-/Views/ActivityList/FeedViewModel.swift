import Foundation
import Alamofire
import SwiftyJSON

protocol FeedViewModelDelegate {
    func didFetchFeeds(_ feeds: [Feed])
}

class FeedViewModel {
    
    var delegate: FeedViewModelDelegate?
    
    var feeds: [Feed] = [] {
        didSet {
            delegate?.didFetchFeeds(feeds)
        }
    }
    
    func fetchFeeds(){
        
        APIClient.shared.fetchFeedsRequest({ (feeds) in
            self.feeds = feeds
        })
    }
}
