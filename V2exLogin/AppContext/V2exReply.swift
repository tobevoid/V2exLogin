//
//  V2exReply.swift
//  V2exLogin
//
//  Created by tripleCC on 10/13/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import Foundation
import ObjectMapper

struct V2exReply: Mappable {
    var content: String?
    var contentRendered: String?
    var created: Int?
    var id: Int?
    var lastModified: Int?
    var thanks: Int?
    var member: V2exMember?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        content         <- map["content"]
        contentRendered <- map["content_rendered"]
        created         <- map["created"]
        id              <- map["id"]
        lastModified    <- map["last_modified"]
        thanks          <- map["thanks"]
        member          <- map["member"]
    }
}
