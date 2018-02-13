import UIKit

class RLController: UIViewController {
    
    let viewModel = RLViewModel()
    let baseView = RLView()
    
    override func viewDidLoad() {
        baseView.viewModel = viewModel
        baseView.delegate = self
        view.addSubview(baseView)
        viewModel.fetchRepository()
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        baseView.frame = view.frame
    }
    
    fileprivate func bindToViewModel() {
        
        viewModel.isLoadingDidSet = { (isloading) in
            if isloading {
                //HUD show
            } else {
                //HUD dismiss
            }
        }
        
        viewModel.repositoriesDidSet = { _ in
            self.baseView.update()
        }
        
        viewModel.errorDidSet = { (error) in
            print(error)
        }
    }
}

extension RLController: RLViewDelegate {
    
    func didSelectCell(_ repository: Repository) {
        let c = UIViewController()
        c.title = repository.name
        navigationController?.pushViewController(c, animated: true)
    }
}
