import UIKit

class ViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {

        let c = LoginViewController()
        let n = UINavigationController(rootViewController: c)
        present(n, animated: false, completion: nil)
    }
    
    
//    override func viewDidLoad() {
//        let req = GetRepositoryRequest()
//        APIClient.shared.send(request: req, completion: { _ in
//            
//        })
//    }
}
