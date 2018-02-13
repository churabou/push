import UIKit

class ViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {

//        let c = LoginViewController()
        let c = MainController()
        let n = UINavigationController(rootViewController: c)
        present(n, animated: false, completion: nil)
    }

}

