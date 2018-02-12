import Foundation


class ActivityViewModel {
    
    fileprivate var timeLineUrl = ""
    fileprivate var currentPage = 1
    
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

    func fetchFeeds(){
        self.isLoading = true
        let request = GetFeedRequest()
        APIClient.shared.send(request: request, completion: { (response) in
            
            switch response {
            case .success(_, let feed):
                self.timeLineUrl = feed.timelineUrl
                self.parceActivity()
            case .failure(_, let message):
                self.isLoading = false
                print("failed \(message)")
            }
        })
    }
    
    func parceActivity() {

        isLoading = true
        let p = AtomParcer()
        let urlString = timeLineUrl+"?page=\(currentPage)"
        
        let result = p.getActivity(urlString)
        isLoading = false
        if result.isEmpty {
            
        } else {
            activities = result
        }
    }
    
    func loadMore() {
        if isLoading { return }
        isLoading = true
        let p = AtomParcer()
        let urlString = timeLineUrl+"?page=\(currentPage)"
        let result = p.getActivity(urlString)

        if result.isEmpty {
       
        } else {
            activities += result
        }
    }
    
}
