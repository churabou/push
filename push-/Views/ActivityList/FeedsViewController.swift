import UIKit
import Alamofire
import SwiftyJSON
import SWXMLHash

class FeedsViewController: UIViewController {
    
    var viewModel = FeedViewModel()
    var tableView = UITableView()
    
    func initializeView() {
        
        tableView.frame = view.frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FeedTableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }

    override func viewDidLoad() {
        initializeView()
        viewModel.delegate = self
        viewModel.state = .requestReady
    }
}

extension FeedsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension FeedsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.feeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FeedTableViewCell else {
            return UITableViewCell()
        }
        cell.feed = viewModel.feeds[indexPath.row]
        return cell
    }
}


extension FeedsViewController: FeedViewModelDelegate {
    
    func didFetchFeeds(_ feeds: [Feed]) {
        tableView.reloadData()
    }
}


