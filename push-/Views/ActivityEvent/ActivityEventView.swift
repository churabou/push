import UIKit

protocol ActivityEventViewDelegate: class {
    func didSelectCell(_ repository: Repository)
}

class ActivityEventView: UIView {
    
    var viewModel: ActivityEventViewModel?
    var delegate: RLViewDelegate?
    
    fileprivate lazy var tableView: UITableView = {
        let t = UITableView()
        t.delegate = self
        t.dataSource = self
        return t
    }()
    
    fileprivate func initializeView() {
        addSubview(tableView)
    }
    
    fileprivate func setFrame() {
        tableView.frame = frame
    }
    
    func update() {
        tableView.reloadData()
    }
    
    override func draw(_ rect: CGRect) {
        setFrame()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ActivityEventView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let event = viewModel?.events[indexPath.row] {
//            delegate?.didSelectCell(repository)
        }
    }
}

extension ActivityEventView: UITableViewDataSource {
    
    
    func  tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if let count = viewModel?.events.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = viewModel?.events[indexPath.row].displayedString
        return cell
    }
}

