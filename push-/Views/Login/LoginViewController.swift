import UIKit

class LoginViewController: UIViewController {
    
    var isLogin = true
    var webView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "login"
        view.backgroundColor = .red
        webView.frame = view.bounds
        webView.delegate = self
        view.addSubview(webView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if isLogin {

            let c = ProfileViewController()
            let n = UINavigationController(rootViewController: c)
            self.present(n, animated: true, completion: nil)

        } else {
            
            let client_id = "3b4c1dac674c96b2b7db"
            guard let url =  URL(string: "https://github.com/login/oauth/authorize?client_id=\(client_id)") else {
                return
            }
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
    
}
//code = 4ab146433594dccdbb29
//
//https://api.github.com/user?access_token=1f3e5e9da619f5486deaa38eeeae18e26ff37369

extension LoginViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        guard let url = request.url?.absoluteString else { return true }
        
        if !url.contains("code") { return true }
        
        let code = url.split(separator: "=")[1]
        OauthManager.getToken(code: String(code), completion: { token in
            if !token.isEmpty {
                let c = ProfileViewController()
                let n = UINavigationController(rootViewController: c)
                self.present(n, animated: true, completion: nil)
            }
        })
        return true
    }
}



