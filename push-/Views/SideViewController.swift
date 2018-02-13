import  UIKit

protocol SideMenuDelegate: class {
    func didSelectMenu(_ index: Int)
}

class SideMenuController: UIViewController {
    
    weak var delegate: SideMenuDelegate?
    
    let baseView = SideMenuView()
    
    override func viewDidLoad() {
        baseView.backgroundColor = .blackTheme
        print(view.frame)
        baseView.frame = view.frame
        baseView.delegate = self
        view.addSubview(baseView)
    }
}

extension SideMenuController: SideMenuViewDelegate {
    
    func didSelectMenu(_ index: Int) {
        delegate?.didSelectMenu(index)
    }
}


protocol SideMenuViewDelegate: class {
    func didSelectMenu(_ index: Int)
}

class SideMenuView: UIView {
    
    weak var delegate: SideMenuViewDelegate?
    fileprivate let menus = ["profie", "repository", "activity", "search", "repository", "activity"] 
    fileprivate lazy var tableView: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        return t
    }()
    
    func initializeView() {
        addSubview(tableView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("init not called")
        initializeView()
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        tableView.frame  = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SideMenuView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectMenu(indexPath.row)
    }
}

extension SideMenuView: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.textAlignment = .right
        cell.textLabel?.text = menus[indexPath.row]
        return cell
    }
}


