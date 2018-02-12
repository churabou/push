import Foundation


class ProfileViewModel {
    
    //MARK: Observe Properties
    var isLoading = false {
        didSet {
            isLoadingDidSet?(isLoading)
        }
    }
    
    var profile = Profile() {
        didSet {
            profileDidSet?(profile)
        }
    }

    var error = "" {
        didSet {
            errorDidSet?(error)
        }
    }

    //MARK: Event
    var isLoadingDidSet:((Bool) -> Swift.Void)?
    var profileDidSet: ((Profile) -> Swift.Void)?
    var errorDidSet: ((String) -> Swift.Void)?

    //MARK: - Actions
    func fetchProfile() {
        let reqest = GetProfileRequest()
        APIClient.shared.send(request: reqest, completion: { response in
            switch response {
            case .success(_, let profile):
                 self.profile = profile
            case .failure(_, let message):
                print(message)
            }
        })
    }
}

//https://medium.com/@IanKeen/mvvm-a-non-reactive-introduction-5a1f33402a32
//https://qiita.com/micchyboy/items/3d09b98b80762bd6f248
//http://techlife.cookpad.com/entry/2017/05/19/100000

