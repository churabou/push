import UIKit


class ActivityViewController: UIViewController {
    
    let viewModel = ActivityViewModel()
    var tableView = UITableView()
    var refreshControll = UIRefreshControl()
    var reachedBottom = false {
        didSet {
            reachedBottomDidSet?(reachedBottom)
        }
    }
    
    var reachedBottomDidSet: ((Bool) -> ())?

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
        viewModel.fetchFeeds()
        bindToViewModel()
    }
    
    func bindToViewModel() {
        
        viewModel.activitiesDidSet = { activities in
            self.tableView.reloadData()
            self.viewModel.isLoading = false
        }
        
        viewModel.isLoadingDidSet = { isLoading in
            if isLoading {
                print("is loading")
                self.refreshControll.beginRefreshing()
                HUD.show()
            } else {
                print("finish loading")
                HUD.hide()
                DispatchQueue.main.asyncAfter(deadline: .now()+0.7, execute: {
                    self.refreshControll.endRefreshing()
                })
            }
        }
        
        reachedBottomDidSet = { reachedBottom in
            if reachedBottom {
                self.viewModel.loadMore()
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

extension ActivityViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //TODO: リクエストするタイミングの調整
        let visibleHeight = scrollView.frame.height - scrollView.contentInset.top - scrollView.contentInset.bottom
        let y = scrollView.contentOffset.y + scrollView.contentInset.top
        let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)
        reachedBottom = y + 10 > threshold
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
