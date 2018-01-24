import UIKit
import Alamofire
import SwiftyJSON
import SWXMLHash

class ActivityViewController: UIViewController {
    
    let viewModel = ActivityViewModel()
    var tableView = UITableView()
    var refreshControll = UIRefreshControl()

    func initializeView() {
        
        tableView.frame = view.frame
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ActivityTableViewCell.self)
        tableView.addSubview(refreshControll)
        view.addSubview(tableView)
    }

    override func viewDidLoad() {
        initializeView()
        self.refreshControll.beginRefreshing()
        viewModel.fetchActivities()
        bindToViewModel()
    }
    
    func bindToViewModel() {
        
        viewModel.activitiesDidSet = { activities in
            self.tableView.reloadData()
        }
        
        viewModel.isLoadingDidSet = { isLoading in
            if isLoading {
                print("is loading")
                self.refreshControll.beginRefreshing()
            } else {
                print("finish loading")
                DispatchQueue.main.asyncAfter(deadline: .now()+0.7, execute: {
                    self.refreshControll.endRefreshing()
                })
            }
        }
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
        return viewModel.activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{

        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ActivityTableViewCell
        cell.setModel(feed: viewModel.activities[indexPath.row])
        return cell
    }
}
