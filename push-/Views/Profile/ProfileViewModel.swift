import Foundation
import Alamofire
import SwiftyJSON


protocol ProfileViewModelDelegate {
    
    func didFetchProfile(_ profile: Profile)
}

class ProfileViewModel {
    

//    MARK: - States
    enum ProfileViewState {
    }
    
    //MARK: - Properties
    var token = ""
    var profile: Profile? {
        didSet {
            delegate?.didFetchProfile(profile!)
        }
    }
    
    var delegate: ProfileViewModelDelegate?
    
    //MARK: - Actions

    func fetchProfile() {
        APIClient.shared.fetchProfileRequest({ (profile) in
            self.profile = profile
        })
    }
}

//https://medium.com/@IanKeen/mvvm-a-non-reactive-introduction-5a1f33402a32
//https://qiita.com/micchyboy/items/3d09b98b80762bd6f248
//http://techlife.cookpad.com/entry/2017/05/19/100000

