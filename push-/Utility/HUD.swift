//
//  HUD.swift
//  push-
//
//  Created by ちゅーたつ on 2018/02/14.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

import UIKit


class HUD: UIViewController {
    
    class func show() {
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        var tc = appdelegate.window?.rootViewController
        
        while tc!.presentedViewController != nil {
             tc = tc!.presentedViewController
        }

        let controller = tc
        let c = HUD()
        c.modalPresentationStyle = .overCurrentContext
        controller?.present(c, animated: false, completion: {
            c.indicator.startAnimating()
        })
        
    }
    
    class func hide() {
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        var tc = appdelegate.window?.rootViewController
        
        while tc!.presentedViewController != nil {
            tc = tc!.presentedViewController
        }
        
        if let controller = tc as? HUD {
            controller.dismiss(animated: false, completion: nil)
        }
    }
    
    
    
    override func viewDidLoad() {
        initializeView()
    }
    
    fileprivate var indicator = UIActivityIndicatorView()
    fileprivate var wrapperView = UIView()
    fileprivate var label = UILabel()
    
    func initializeView() {
        
        view.backgroundColor = UIColor(white: 0, alpha: 0)
        wrapperView.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        wrapperView.frame.size = CGSize(width: 80, height: 80)
        wrapperView.center = view.center
        view.addSubview(wrapperView)
        
        indicator.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        wrapperView.addSubview(indicator)
        label.frame = CGRect(x: 0, y: 50, width: 80, height: 30)
        label.text = "loading"
        label.textAlignment = .center
        wrapperView.addSubview(label)
    }
}
