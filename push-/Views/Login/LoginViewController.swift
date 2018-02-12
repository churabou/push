import UIKit


class LoginViewController: UIViewController {
    
    fileprivate var viewModel = LoginViewModel()
    fileprivate var webView = UIWebView()
    
    fileprivate func initializeView() {
        title = "login"
        webView.frame = view.bounds
        webView.delegate = self
        view.addSubview(webView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
        viewModel.delegate = self
        viewModel.state = .requestLogin(isLogin: false)
    }
    
    fileprivate func loadLoginView() {
        
        let client_id = Config.client_id
        guard let url =  URL(string: "https://github.com/login/oauth/authorize?client_id=\(client_id)") else {
            return
        }
        let request = URLRequest(url: url)
        webView.loadRequest(request)
    }
    
    fileprivate func presenView() {
        
        let c = ProfileViewController()
        let n = UINavigationController(rootViewController: c)
        self.present(n, animated: true, completion: nil)
    }
}


extension LoginViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        //TODO: ロジックがここにあるのは不自然
        guard let url = request.url?.absoluteString else { return true }
        if !url.contains("code") { return true }
        viewModel.state = .requestReady(code: String(url.split(separator: "=")[1]))
        return true
    }
}

extension LoginViewController: LoginViewModelDelegate {
    
    func requestLogin(_ isLogin: Bool) {
        
        if isLogin {
            presenView()
        } else {
            loadLoginView()
        }
    }
    
    func didLoginComplete() {
        presenView()
    }
    
    func didLoginFailed() {
    }
}



