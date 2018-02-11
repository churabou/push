import Foundation

protocol LoginViewModelDelegate {
    
    func requestLogin(_ isLogin: Bool)
    func didLoginComplete()
    func didLoginFailed()
}

class LoginViewModel {
    
    var delegate: LoginViewModelDelegate?
    
    enum LoginViewState {
        
        case requestLogin(isLogin: Bool)
        case requestReady(code: String)
        case loginComplete(token: String)
        case loginFailed
        case none
    }
    
    var state: LoginViewState = .none {
        
        didSet {
            //var stateDidSet: ((LoginViewState) -> Swift.Void)?
            switch state {
            case .requestLogin(let isLogin):
                delegate?.requestLogin(isLogin)
            case .requestReady(let code):
                featchToken(code: code)
            default:
                return
            }
        }
    }
    
    //var stateDidSet: ((LoginViewState) -> Swift.Void)?
    
    
    func featchToken(code: String) {
        
        OauthManager.getToken(code: String(code), completion: { token in
            if !token.isEmpty {
                
                Config.token = token
                self.delegate?.didLoginComplete()
            }
        })
    }
}
