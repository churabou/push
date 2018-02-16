import Foundation

private struct Repo {
    var name: String
    
    init(_ dic: [String: Any]) {
        
        guard let name = dic["name"] as? String else {
            fatalError("")
        }
        
        self.name = name
    }
}

struct Event {
    
    var type: String
    var user: User
    var repoName: String
    
    init(_ object: Any) {
  
        guard let dic = object as? [String: Any] else {
            fatalError("辞書変換失敗")
        }
        
        guard let type = dic["type"] as? String else {
            fatalError("type missing")
        }
        
        guard let actor = dic["actor"] as? [String : Any] else {
            fatalError("actor missing")
        }
        
        guard let repo = dic["repo"] as? [String : Any] else {
            fatalError("repo missing")
        }
        
        self.type = type
        self.user = User.decode(actor)
        self.repoName = Repo(repo).name
    }

    
    static func map(_ object: Any) {

        guard let ary = object as? [Any] else {
            fatalError("辞書変換失敗")
        }
        
        let result = ary.map { Event($0) }
        
        result.forEach {
            print($0.displayedString)
        }
    }
    
    var displayedString: String {
        
        var str = ""
        str += user.name
        str += " \(type) \(repoName) "
        return str
    }
}
