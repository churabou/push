import Foundation

protocol LoginViewModelDelegate {
    
    func requestLogin(_ isLogin: Bool)
    func didLoginComplete()
    func didLoginFailed()
}

//requestLogin -> 判定 -> webView表示 -> リダイレクトの値でリクエスト -> complete
class LoginViewModel {
    
    var delegate: LoginViewModelDelegate?
    
    enum LoginViewState {
        
        case requestLogin(isLogin: Bool)
        case requestReady(code: String)
        case loginComplete
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
    

}
