//
//  V2exNode.swift
//  V2exLogin
//
//  Created by tripleCC on 10/13/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import Foundation
import ObjectMapper

struct V2exNode: Mappable {
    var id: Int?
    var name: String?
    var title: String?
    var titleAlternative: String?
    var url: String?
    var topics: Int?
    var avatar: V2exAvatar?
    var header: String?
    var footer : String?
    var created: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id                  <- map["id"]
        name                <- map["name"]
        title               <- map["title"]
        titleAlternative    <- map["title_alternative"]
        url                 <- map["url"]
        topics              <- map["topics"]
        avatar              <- map["avatar"]
        header              <- map["header"]
        footer              <- map["footer"]
        created             <- map["created"]
    }
}
