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
        bindToViewModel()
        viewModel.fetchProfile()
    }
    
    
    fileprivate func bindToViewModel() {
        
        viewModel.profileDidSet = { profile in

            self.nameLabel.text = "logging in as \(profile.name)"
            self.imageView.loadImage(urlString: profile.iconURL)
            self.present()
        }
    }
    
    fileprivate func present()  {
        let c = MainController()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.navigationController?.pushViewController(c, animated: true)
        })
    }
}


import UIKit


class ProfileController: UIViewController {
    
    fileprivate var topWrpperView = UIView()
    fileprivate var imageView = UIImageView()
    fileprivate var nameLabel = UILabel()
    fileprivate let viewModel = ProfileViewModel()
    
    fileprivate func initializeView() {
        
        view.backgroundColor = .white
        topWrpperView.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
        topWrpperView.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: 200)
        view.addSubview(topWrpperView)
        let size: CGFloat = 100
        imageView.frame.origin = CGPoint(x: view.frame.width-50, y: 64+75)
        imageView.frame.size = CGSize(width: size, height: size)
        imageView.center = topWrpperView.center
        imageView.layer.cornerRadius = size / 2
        imageView.clipsToBounds = true
        topWrpperView.addSubview(imageView)
        
        nameLabel.frame.origin = CGPoint(x:  view.frame.width-50, y: 64+130)
        nameLabel.frame.size = CGSize(width: 100, height: 20)
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.boldSystemFont(ofSize: 13)
        nameLabel.textColor = .white
        topWrpperView.addSubview(nameLabel)
    }
    
    override func viewDidLoad() {
        initializeView()
        bindToViewModel()
        viewModel.fetchProfile()
    }
    
    
    fileprivate func bindToViewModel() {
        
        viewModel.profileDidSet = { profile in
            
            self.nameLabel.text = profile.name
            self.imageView.loadImage(urlString: profile.iconURL)
        }
    }
}

