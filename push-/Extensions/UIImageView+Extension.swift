import UIKit


extension UIImageView {
    
    //画像を非同期で読み込む
    func loadImage(urlString: String, completion: @escaping () -> () = {}){
        let req = URLRequest(url: NSURL(string:urlString)! as URL,
                             cachePolicy: .returnCacheDataElseLoad,
                             timeoutInterval: 5 * 60);
        let conf =  URLSessionConfiguration.default;
        let session = URLSession(configuration: conf, delegate: nil, delegateQueue: OperationQueue.main);
        
        session.dataTask(with: req, completionHandler:
            { (data, resp, err) in
                if((err) == nil){ //Success
                    let image = UIImage(data:data!)
                    self.image = image;
                    completion()
                }else{ //Error
                    print("AsyncImageView:Error \(err?.localizedDescription)");
                }
        }).resume();
    }
}

extension UIImage {
    
    //画像を非同期で読み込む
    static func loadImage(urlString: String, completion: @escaping (UIImage) -> ()){
        let req = URLRequest(url: NSURL(string:urlString)! as URL,
                             cachePolicy: .returnCacheDataElseLoad,
                             timeoutInterval: 5 * 60);
        let conf =  URLSessionConfiguration.default;
        let session = URLSession(configuration: conf, delegate: nil, delegateQueue: OperationQueue.main);
        
        session.dataTask(with: req, completionHandler:
            { (data, resp, err) in
                if((err) == nil){ //Success
                    let image = UIImage(data:data!)
                    completion(image!)
                }else{ //Error
                    print("AsyncImageView:Error \(err?.localizedDescription)");
                }
        }).resume();
    }
}
