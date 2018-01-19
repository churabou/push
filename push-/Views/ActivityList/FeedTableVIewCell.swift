import UIKit

class FeedTableViewCell: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initializeView()
    }
    
    var feed: Feed = Feed() {
        
        didSet {
            iconView.loadImage(urlString: feed.icon)
            activityLabel.text = feed.title
            nameLabel.text = feed.name
        }
    }
    
    let height: CGFloat = 100
    var centerY: CGFloat {
        return height / 2
    }
    
    var iconView = UIImageView()
    var activityLabel = UILabel()
    var nameLabel = UILabel()

    func initializeView() {
        
        let size: CGFloat = 40
        iconView.frame.origin = CGPoint(x: 10, y: centerY-20)
        iconView.frame.size = CGSize(width: size, height: size)
        iconView.layer.cornerRadius = size / 2
        iconView.clipsToBounds = true
        addSubview(iconView)
        

        activityLabel.frame.origin = CGPoint(x: 70, y: centerY-20)
        activityLabel.frame.size = CGSize(width: bounds.width-80, height: 40)
        addSubview(activityLabel)
        
        addSubview(nameLabel)
    }
}
