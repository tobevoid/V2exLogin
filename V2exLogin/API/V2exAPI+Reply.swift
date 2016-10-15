//
//  V2exAPI+Reply.swift
//  V2exLogin
//
//  Created by tripleCC on 10/13/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import Foundation
import Moya
import RxSwift

extension RxMoyaProvider {
    func fetchRepliesWithTopicId(_ topicId: Int) -> Observable<[V2exReply]> {
        return V2exProvider.request(.Replies(topicId: topicId))
            .mapObjectArray()
            .shareReplay(1)
    }
    
//    func replyWithTopicId(_ topicId: Int) -> Observable<Response> {
//        
//    }
}
