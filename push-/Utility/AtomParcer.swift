import Foundation

class AtomParcer: NSObject {
    
    
    func getActivity(_ url_text: String) -> [Activity] {
        
        guard let url = NSURL(string: url_text) else{
            return []
        }
        
        // インターネット上のXMLを取得し、NSXMLParserに読み込む
        guard let parser = XMLParser(contentsOf: url as URL) else{
            return []
        }
        parser.delegate = self
        parser.parse()
        return feeds
    }
    
    
    var currentFeed = Activity()
    var feeds: [Activity] = []
    var tag: Tag = .other
    
    var isReadTitle = false
    var isReadIcon = false
    
    
    enum Tag {
        
        case entry
        case title
        case name
        case media
        case other
    }
}



extension AtomParcer: XMLParserDelegate {
    
    // XML解析開始時に実行されるメソッド
    func parserDidStartDocument(_ parser: XMLParser) {
        print("XML解析開始しました")
    }
    
    // 解析中に要素の開始タグがあったときに実行されるメソッド
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        switch elementName {
        case "entry":
            currentFeed = Activity()
        case "title":
            tag = .title
            isReadTitle = false
        case "media:thumbnail":
            tag = .media
            currentFeed.icon = attributeDict["url"]!
        default:
            tag = .other
        }
    }
    
    // 開始タグと終了タグでくくられたデータがあったときに実行されるメソッド
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch tag {
        case .title:
            
            if !isReadTitle {
                currentFeed.title = string
                isReadTitle = !isReadTitle
            }
        case .media:
            return
        default:
            return
        }
    }
    
    // 解析中に要素の終了タグがあったときに実行されるメソッド
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "entry" {
            feeds.append(currentFeed)
        }
    }
    
    // XML解析終了時に実行されるメソッド
    func parserDidEndDocument(_ parser: XMLParser) {
        print("XML解析終了しました")
    }
    
    // 解析中にエラーが発生した時に実行されるメソッド
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("エラー:" + parseError.localizedDescription)
    }
}

