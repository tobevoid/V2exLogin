//
//  V2exAvatar.swift
//  V2exLogin
//
//  Created by tripleCC on 10/13/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import Foundation
import ObjectMapper

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
