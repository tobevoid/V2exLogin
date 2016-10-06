//
//  V2exMember.swift
//  V2exLogin
//
//  Created by tripleCC on 10/5/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import Foundation
import ObjectMapper

struct V2exMember: Mappable {
    var status: String?
    var id: Int?
    var url: String?
    var username: String?
    var website: String?
    var twitter: String?
    var psn: String?
    var github: String?
    var btc: String?
    var location: String?
    var tagline: String?
    var bio: String?
    var created: Int?
    var avatar: V2exAvatar?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        status      <- map["status"]
        id          <- map["id"]
        url         <- map["url"]
        username    <- map["username"]
        website     <- map["username"]
        twitter     <- map["twitter"]
        psn         <- map["psn"]
        github      <- map["github"]
        btc         <- map["btc"]
        location    <- map["location"]
        tagline     <- map["tagline"]
        bio         <- map["bio"]
        created     <- map["created"]
        avatar      <- map
    }
}

struct V2exAvatar: Mappable {
    var mini: String?
    var large: String?
    var normal: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        mini    <- map["avatar_mini"]
        normal  <- map["avatar_normal"]
        large   <- map["avatar_large"]
    }
}
