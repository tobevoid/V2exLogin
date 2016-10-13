//
//  V2exTopic.swift
//  V2exLogin
//
//  Created by tripleCC on 10/13/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import Foundation
import ObjectMapper

struct V2exTopic: Mappable {
    var id: Int?
    var title: String?
    var url: String?
    var content: String?
    var contentRendered: String?
    var replies: Int?
    var created: Int?
    var lastModified: Int?
    var lastTouched: Int?
    var member: V2exMember?
    var node: V2exNode?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id              <- map["id"]
        title           <- map["title"]
        url             <- map["url"]
        content         <- map["content"]
        contentRendered <- map["content_rendered"]
        replies         <- map["replies"]
        created         <- map["created"]
        lastModified    <- map["last_modified"]
        lastTouched     <- map["last_touched"]
        member          <- map["member"]
        node            <- map["node"]
    }
}
