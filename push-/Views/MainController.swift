import UIKit

class MainController: UIViewController {
    
    fileprivate var container = ContainerViewController()
    fileprivate var sideMenu = SideMenuController()
    fileprivate var isSideMenuShowing = false

    override func viewDidLoad() {
        title = "Main"
        setNavigationBar()
        setContainerViewController()
        setSideMenu()
//        didSelectMenu(2)

    }

    fileprivate func setNavigationBar() {

        let leftBarItem = UIBarButtonItem(title: "menu", style: .plain, target: self, action: #selector(actionMenu))
        navigationItem.leftBarButtonItem = leftBarItem
    }
    
    @objc fileprivate func actionMenu() {
        print("toggel menu")
        toggleSideMenu(isSideMenuShowing)
    }
    
    fileprivate func toggleSideMenu(_ isShowing: Bool) {
        
        let k: CGFloat = isShowing ? -1 : -1/3
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.sideMenu.view.transform = CGAffineTransform(translationX: (self.view.frame.width * k), y: 0)
        })
        isSideMenuShowing = !isSideMenuShowing
    }
    
    fileprivate func setContainerViewController() {
        
        addChildViewController(container)
        view.addSubview(container.view)
        container.didMove(toParentViewController: self)
    }
    
    fileprivate func setSideMenu() {

        sideMenu.delegate = self
        addChildViewController(sideMenu)
        view.addSubview(sideMenu.view)
        sideMenu.didMove(toParentViewController: self)
        sideMenu.view.transform = CGAffineTransform(translationX: (view.bounds.width * -1), y: 0)
    }
}

extension MainController: SideMenuDelegate {
    
    func didSelectMenu(_ index: Int) {

        toggleSideMenu(true)
        var c = UIViewController()
        switch index {
        case 0: c.view.backgroundColor = .red
        case 1: c = ActivityEventController()
        case 2: c = ActivityViewController()
        case 3: c.view.backgroundColor = .cyan
        case 4: c = RLController()
        case 5: c.view.backgroundColor = .black
        default: return
        }
        container.set(c)
    }
}
