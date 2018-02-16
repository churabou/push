import Foundation

class ActivityEventViewModel {
    
    fileprivate var currentPage = 1
    fileprivate var isFeachedAll = false
    
    //success
    var events: [Event] = [] {
        didSet {
            eventsDidSet?(events)
        }
    }
    //failed
    var error = "" {
        didSet {
            errorDidSet?(error)
        }
    }
    //loading
    var isLoading = false {
        didSet {
            isLoadingDidSet?(isLoading)
        }
    }
    
    var isLoadingDidSet:((Bool) -> Swift.Void)?
    var eventsDidSet: (([Event]) -> Swift.Void)?
    var errorDidSet: ((String) -> Swift.Void)?
    
    
    //MARK: Action
    
    func fetchEvent(){
        self.isLoading = true
        let request = GetEventRequest(.news)
        GithubSession.send(request: request, completion: { (response) in
            self.isLoading = false
            switch response {
            case .success(_, let events):
                self.events = events
            case .failure(_, let message):
                print("failed \(message)")
            }
        })
    }
    
    func loadMoreEvent() {
        if isLoading || isFeachedAll { return }
        isLoading = true
    }
    
}

