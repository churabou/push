import UIKit


class ActivityTableView: UITableView {
    

    var activities: [Activity] = []
    
    func reloadData(_ activities: [Activity]) {
        self.activities = activities
        reloadData()
    }
    
    var reachedBottom = true {
        didSet {
            reachedBottomDidSet?(reachedBottom)
        }
    }
    var reachedBottomDidSet: ((Bool) -> Swift.Void)?

    init() {
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension ActivityTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ActivityTableViewCell.defaultHeight
    }
}

extension ActivityTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ActivityTableViewCell
        cell.setModel(feed: activities[indexPath.row])
        return cell
    }
}
