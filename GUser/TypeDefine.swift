//
//  TypeDefine.swift
//  GUser
//
//  Created by Wei Kuo on 2020/2/21.
//  Copyright © 2020 Wei Kuo. All rights reserved.
//

import Foundation



/*{
  "login": "mojombo",
  "id": 1,
  "node_id": "MDQ6VXNlcjE=",
  "avatar_url": "https://avatars0.githubusercontent.com/u/1?v=4",
  "gravatar_id": "",
  "url": "https://api.github.com/users/mojombo",
  "html_url": "https://github.com/mojombo",
  "followers_url": "https://api.github.com/users/mojombo/followers",
  "following_url": "https://api.github.com/users/mojombo/following{/other_user}",
  "gists_url": "https://api.github.com/users/mojombo/gists{/gist_id}",
  "starred_url": "https://api.github.com/users/mojombo/starred{/owner}{/repo}",
  "subscriptions_url": "https://api.github.com/users/mojombo/subscriptions",
  "organizations_url": "https://api.github.com/users/mojombo/orgs",
  "repos_url": "https://api.github.com/users/mojombo/repos",
  "events_url": "https://api.github.com/users/mojombo/events{/privacy}",
  "received_events_url": "https://api.github.com/users/mojombo/received_events",
  "type": "User",
  "site_admin": false
}*/


struct GHUser : Decodable {
    var name:String
    var isAdmin:Bool
    var picURL:URL

    enum CodingKeys: String, CodingKey {
        case name =  "login"
        case isAdmin =  "site_admin"
        case picURL =  "avatar_url"
    }
    
}
