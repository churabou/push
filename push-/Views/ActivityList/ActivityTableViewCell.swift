import UIKit


class ActivityTableViewCell: UITableViewCell, NibLoadable, Reusable {
    
    static let defaultHeight: CGFloat = 90

    @IBOutlet weak var iconView: UIImageView! {
        didSet {
            iconView.layer.cornerRadius = 50/2
            iconView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var activityLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    func setModel(feed: Feed) {
        iconView.loadImage(urlString: feed.icon)
        activityLabel.text = feed.title
        timeLabel.text = "days ago"
    }
}
