import UIKit

protocol RLViewDelegate: class {
    func didSelectCell(_ repository: Repository)
}

class RLView: UIView {
 
    var viewModel: RLViewModel?
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
}

extension RLView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let repository = viewModel?.repositories[indexPath.row] {
            delegate?.didSelectCell(repository)
        }
    }
}

extension RLView: UITableViewDataSource {
    
    
    func  tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = viewModel?.repositories.count {
            return count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
