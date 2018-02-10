import UIKit


class ProfileViewController: UIViewController {
    
    fileprivate var imageView = UIImageView()
    fileprivate var nameLabel = UILabel()
    fileprivate let viewModel = ProfileViewModel()
    
    fileprivate func initializeView() {
        
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
        viewModel.fetchProfile()
        bindToViewModel()
    }
    
    
    fileprivate func bindToViewModel() {
        
        viewModel.profileDidSet = { profile in

            self.nameLabel.text = "logging in as \(profile.name)"
            self.imageView.loadImage(urlString: profile.iconURL)
            
            let c = ActivityViewController()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.navigationController?.pushViewController(c, animated: true)
            })
        }
    }
}
