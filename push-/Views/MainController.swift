import UIKit

class MainController: UIViewController {
    
    
    override func viewDidLoad() {
        title = "Main"
        setNavigationBar()
        setContainerViewController()
        setSideMenu()

    }

    fileprivate func setNavigationBar() {
        
        let leftBarItem = UIBarButtonItem(title: "menu", style: .plain, target: self, action: #selector(actionMenu))
        navigationItem.leftBarButtonItem = leftBarItem
    }
    
    //toggle menuView
    @objc fileprivate func actionMenu() {
        print("toggel menu")
        if isSideMenuShowing {
            hideMenuView()
        } else {
            showMenuView()
        }
    }
    
    fileprivate func hideMenuView() {
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.sideMenu.view.transform = CGAffineTransform(translationX: (self.view.frame.width * -1), y: 0)
        })
        isSideMenuShowing = false
    }
    
    fileprivate func showMenuView() {
        UIView.animate(withDuration: 0.2, animations: {
            
            self.sideMenu.view.transform = CGAffineTransform(translationX: (self.view.frame.width * -1/3), y: 0)
        })
        isSideMenuShowing = true
    }
    
    
    var sideMenu = SideMenuController()
    var isSideMenuShowing = false
    func setSideMenu() {
        
        sideMenu.delegate = self
        addChildViewController(sideMenu)
        view.addSubview(sideMenu.view)
        sideMenu.didMove(toParentViewController: self)
        sideMenu.view.transform = CGAffineTransform(translationX: (view.bounds.width * -1), y: 0)
    }
    
    var container = ContainerViewController()
    
    func setContainerViewController() {
        
        addChildViewController(container)
        view.addSubview(container.view)
        container.didMove(toParentViewController: self)
    }
}

extension MainController: SideMenuDelegate {
    func didSelectMenu(_ index: Int) {
       
        hideMenuView()
        var c = UIViewController()
        switch index {
        case 0: c.view.backgroundColor = .red
        case 1: c.view.backgroundColor = .yellow
        case 2: c = ActivityViewController()
        case 3: c.view.backgroundColor = .cyan
        case 4: c.view.backgroundColor = .white
        case 5: c.view.backgroundColor = .black
        default: return
        }
        container.set(c)
//        navigationController?.pushViewController(c, animated: true)
    }
}


class ContainerViewController: UIViewController {
    
    
    fileprivate func set(_ controller: UIViewController) {
        
        childViewControllers.forEach { c in
            c.removeFromParentViewController()
            c.view.removeFromSuperview()
        }
        addChildViewController(controller)
        view.addSubview(controller.view)
        controller.didMove(toParentViewController: self)
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .orange
    }
}
//extension UIViewController {
//
//    var sideMenu: SideMenuController? {
//
//        var parentViewController = self.parent
//        while parentViewController != nil {
//            if let c = parentViewController as? SideMenuController {
//                return c
//            }
//            parentViewController = parentViewController!.parent
//        }
//        return nil
//    }
//}

