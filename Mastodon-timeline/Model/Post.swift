//
//  Post.swift
//  Mastodon-test-api
//
//  Created by Роман Мисников on 02.04.2018.
//  Copyright © 2018 Роман Мисников. All rights reserved.
//

import Foundation

class Account {
    var acct: String?
    var avatarUrl: String?
    var avatar_static: String?
    var created_at: String?
    var display_name: String?
    var followers_count: String?
    var header: String?
    var header_static: String?
    var id: String?
    var locked: String?
    var note: String?
    var statuses_count: String?
    var url: String?
    var username: String?
    
    init(account: [String: Any]) {
        acct = account["acct"] as? String
        avatarUrl = account["avatarUrl"] as? String
        avatar_static = account["avatar_static"] as? String
        created_at = account["created_at"] as? String
        display_name = account["display_name"] as? String
        followers_count = account["followers_count"] as? String
        header = account["header"] as? String
        header_static = account["header_static"] as? String
        id = account["id"] as? String
        locked = account["locked"] as? String
        note = account["note"] as? String
        statuses_count = account["statuses_count"] as? String
        url = account["url"] as? String
        username = account["username"] as? String
    }
}

class Post {
    var accountData: [String: Any]?
        var account: Account?
    var content: String?
    var created_at: String?
    var emojis: String?
    var favourites_count: String?
    var id: String?
    var in_reply_to_account_id: String?
    var in_reply_to_id: String?
    var language: String?
    var media_attachments: String?
    var mentions: String?
    var reblog: String?
    var reblog_count: String?
    var sensitive: String?
    var spoiler_text: String?
    var tags: String?
    var uri: String?
    var url: String?
    var visibility: String?
    
    init(json: [String: Any]) {
        accountData = json["account"] as? [String: Any]
        if let data = accountData {
            account = Account(account: data)
        }
        content = json["content"] as? String
        created_at = json["created_at"] as? String
        emojis = json["emojis"] as? String
        favourites_count = json["favourites_count"] as? String
        id = json["id"] as? String
        in_reply_to_account_id = json["in_reply_to_account_id"] as? String
        in_reply_to_id = json["in_reply_to_id"] as? String
        language = json["language"] as? String
        media_attachments = json["media_attachments"] as? String
        mentions = json["mentions"] as? String
        reblog = json["reblog"] as? String
        reblog = json["reblog"] as? String
        sensitive = json["sensitive"] as? String
        spoiler_text = json["spoiler_text"] as? String
        tags = json["tags"] as? String
        url = json["url"] as? String
        uri = json["uri"] as? String
        visibility = json["visibility"] as? String
        
    }
}
    

