//
//  User.swift
//  TweetMD
//
//  Created by Kimberly Hsiao on 1/23/19.
//  Copyright © 2019 Doximity. All rights reserved.
//

import Foundation

struct UserMention {
    let handle: String
    
    init(_ handle: String) {
        self.handle = handle
    }
}

struct User: Decodable {
    let id: Int
    let name: String
    let handle: String
    let profileImageUrlString: String
    
    var profileImageUrl: URL? {
        return URL(string: profileImageUrlString)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case handle = "screen_name"
        case profileImageUrlString = "profile_image_url_https"
    }
}
