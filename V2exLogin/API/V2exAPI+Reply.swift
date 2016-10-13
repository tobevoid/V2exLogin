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
    func fetchRepliesWithTopicId(_ topicId: String) -> Observable<[V2exReply]> {
        return V2exProvider.request(.Replies(topicId: topicId))
            .retry(1)
            .mapObjectArray()
            .shareReplay(1)
    }
}
