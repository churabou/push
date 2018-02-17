import UIKit

class ActivityEventController: UIViewController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ target: ActivityEventTarget) {
        self.init(nibName: nil, bundle: nil)
        viewModel.target = target
    }
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
