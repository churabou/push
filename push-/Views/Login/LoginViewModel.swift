import Foundation

protocol LoginViewModelDelegate {
    
    func requestLogin(_ isLogin: Bool)
    func didFetchToken(_ token: String)
}

class LoginViewModel {
    
    var delegate: LoginViewModelDelegate?
    var code = "" {//request ready request success failed
        didSet {
            featchToken()
        }
    }
    
    var isLogin = false {
        didSet {
            delegate?.requestLogin(isLogin)
        }
    }
    
    func featchToken() {
        
        OauthManager.getToken(code: String(code), completion: { token in
            if !token.isEmpty {
                self.delegate?.didFetchToken(token)
            }
        })
    }
}
