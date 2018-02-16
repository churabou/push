//
//  Event.swift
//  push-
//
//  Created by ちゅーたつ on 2018/02/16.
//  Copyright © 2018年 ちゅーたつ. All rights reserved.
//

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

private struct Actor {

    var login: String
    var iconURL: String
    
    init(_ dic: [String: Any]) {

        guard let login = dic["login"] as? String else {
            fatalError("")
        }
        
        guard let iconURL = dic["avatar_url"] as? String else {
            fatalError("aa")
        }
        
        self.login = login
        self.iconURL = iconURL
    }
}

struct Event {
    
    var type: String
    var iconURL: String
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
        self.iconURL = Actor(actor).iconURL
        self.repoName = Repo(repo).name
    }

    
    static func map(_ object: Any) {
        
        
        guard let ary = object as? [Any] else {
            fatalError("辞書変換失敗")
        }
        
        let result = ary.map { Event($0) }
        
        result.forEach { print($0.repoName) }
    }
}
