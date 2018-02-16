import UIKit

class ActivityEventController: UIViewController {
    
//    internal var type: ActivityEventTarget?
    let viewModel = ActivityEventViewModel()
    let baseView = ActivityEventView()
    
    override func viewDidLoad() {
        baseView.viewModel = viewModel
//        baseView.delegate = self
        baseView.frame = view.frame
        view.addSubview(baseView)
        bindToViewModel()
        viewModel.fetchEvent()
    }
    
    fileprivate func bindToViewModel() {
        
        viewModel.isLoadingDidSet = { (isloading) in
            if isloading {
                HUD.show()
            } else {
                HUD.hide()
            }
        }
        
        viewModel.eventsDidSet = { _ in
            self.baseView.update()
        }
        
        viewModel.errorDidSet = { (error) in
            print(error)
        }
    }
}
