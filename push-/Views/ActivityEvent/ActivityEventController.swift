import UIKit

class ActivityEventController: UIViewController {
    
    
    func initializeView() {
        title = "event"
        view.backgroundColor = .green
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        initializeView()
//        let req = GetEventRequest(.news)
//        GithubSession.send(request: req, completion: { response in
//            switch response {
//            case .success:
//                return
//            case .failure:
//                return
//            }
//        })
        
        let req = GetEventRequest(.user)
        GithubSession.send(request: req, completion: { response in
            switch response {
            case .success:
                return
            case .failure:
                return
            }
        })
    }
}
