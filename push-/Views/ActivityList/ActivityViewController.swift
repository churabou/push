import UIKit
import Alamofire
import SwiftyJSON
import SWXMLHash

class ActivityViewController: UIViewController {
    
    var viewModel = ActivityViewModel()
    var tableView = UITableView()
    var refreshControll = UIRefreshControl()

    func initializeView() {
        
        tableView.frame = view.frame
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(ActivityTableViewCell.self)
        tableView.addSubview(refreshControll)
        view.addSubview(tableView)
    }

    override func viewDidLoad() {
        initializeView()
        refreshControll.beginRefreshing()
        viewModel.delegate = self
        viewModel.state = .requestReady
    }
}

extension ActivityViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ActivityTableViewCell.defaultHeight
    }
}

extension ActivityViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FeedTableViewCell else {
//            return UITableViewCell()
//        }
//        cell.updateView(feed: viewModel.feeds[indexPath.row])
        
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ActivityTableViewCell
        cell.setModel(feed: viewModel.feeds[indexPath.row])
        return cell
    }
}


extension ActivityViewController: ActivityViewModelDelegate {
    
    func didFetchFeeds(_ feeds: [Feed]) {
        tableView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.7, execute: {
            self.refreshControll.endRefreshing()
        })
    }
}


