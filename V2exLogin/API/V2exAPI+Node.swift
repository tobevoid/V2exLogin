//
//  V2exAPI+Node.swift
//  V2exLogin
//
//  Created by tripleCC on 10/13/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import Foundation
import Moya
import RxSwift

extension RxMoyaProvider {
    func fetchAllNodes() -> Observable<[V2exNode]> {
        return V2exProvider.request(.AllNodes)
            .mapObjectArray()
            .shareReplay(1)
    }
    
    func fetchShowNodesWithName(_ name: String) -> Observable<[V2exNode]> {
        return V2exProvider.request(.ShowNodes(name: name))
            .mapObjectArray()
            .shareReplay(1)
    }
}
