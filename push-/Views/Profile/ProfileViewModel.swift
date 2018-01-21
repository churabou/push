import Foundation
import Alamofire
import SwiftyJSON



protocol ProfileViewModelDelegate {
     //MARK: - Events
    func didFetchProfile(_ profile: Profile)
}

class ProfileViewModel {
    

    //MARK: - States
    enum ProfileViewState {
        case requestReady
        case requestSuccess(profile: Profile)
        case requestFailed
        case none
    }
    
    //MARK: - Properties
    var state: ProfileViewState = .none {
        didSet {
            switch state {
            case .requestReady:
                fetchProfile()
            case .requestSuccess(let profile):
                delegate?.didFetchProfile(profile)
            default:
                return
            }
        }
    }
    
    var delegate: ProfileViewModelDelegate?
    
    //MARK: - Actions


    func fetchProfile() {
        let reqest = GetProfileRequest()
        APIClient.shared.send(request: reqest, completion: { res in
            switch res {
            case .success(_, let profile):
                 self.state = .requestSuccess(profile: profile)
            case .failure(_, let message):
                print(message)
            }
        })
    }
}

//https://medium.com/@IanKeen/mvvm-a-non-reactive-introduction-5a1f33402a32
//https://qiita.com/micchyboy/items/3d09b98b80762bd6f248
//http://techlife.cookpad.com/entry/2017/05/19/100000

