//
//  V2exAPI+Topic.swift
//  V2exLogin
//
//  Created by tripleCC on 10/13/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import Foundation
import Moya
import RxSwift

extension RxMoyaProvider {
    func fetchLatestTopics() -> Observable<[V2exTopic]> {
        return V2exProvider.request(.LatestTopics)
            .retry(1)
            .mapObjectArray()
            .shareReplay(1)
    }
    
    func fetchHotTopics() -> Observable<[V2exTopic]> {
        return V2exProvider.request(.HotTopics)
            .retry(1)
            .mapObjectArray()
            .shareReplay(1)
    }
    
    func fetchTopics(nodeId: String? = nil,
                     nodeName: String? = nil,
                     username: String? = nil,
                     page: Int) -> Observable<[V2exTopic]> {
        return V2exProvider.request(.Topics(nodeId: nodeId,
                                            nodeName: nodeName,
                                            username: username,
                                            page: page))
            .retry(1)
            .mapObjectArray()
            .shareReplay(1)
    }
}
