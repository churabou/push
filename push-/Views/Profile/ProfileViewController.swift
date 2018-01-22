import UIKit

class ProfileViewController: UIViewController {
    
    private var imageView = UIImageView()
    private var nameLabel = UILabel()
    private var viewModel = ProfileViewModel()
    
    private func initializeView() {
        
        view.backgroundColor = UIColor(white: 0.8, alpha: 1/0)
        
        let size: CGFloat = 150
        imageView.frame.size = CGSize(width: size, height: size)
        imageView.layer.cornerRadius = size / 2
        imageView.clipsToBounds = true
        imageView.center = view.center
        view.addSubview(imageView)
        
        nameLabel.frame.size = CGSize(width: 200, height: 50)
        nameLabel.center = view.center
        nameLabel.frame.origin.y += size
        nameLabel.textAlignment = .center
        view.addSubview(nameLabel)
    }
    
    override func viewDidLoad() {
        initializeView()
        viewModel.delegate = self
        viewModel.state = .requestReady
    }
}

extension ProfileViewController: ProfileViewModelDelegate {
    
    func didFetchProfile(_ profile: Profile) {
        
        nameLabel.text = "logging in as \(profile.name)"
        imageView.loadImage(urlString: profile.iconURL)
        
        let c = ActivityViewController()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.navigationController?.pushViewController(c, animated: true)
        })
    }
}
