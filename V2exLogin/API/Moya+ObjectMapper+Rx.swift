//
//  Moya+Rx.swift
//  V2exLogin
//
//  Created by tripleCC on 10/6/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import ObjectMapper

extension ObservableType where E == Response {
    public func mapObject<T: Mappable>() -> RxSwift.Observable<T> {
        return mapJSON()
            .observeOn(ConcurrentDispatchQueueScheduler(globalConcurrentQueueQOS: .background))
            .flatMap {
                return Mapper<T>().map(JSONObject: $0)
                    .flatMap{ Observable.just($0) } ??
                    Observable.error(NSError(domain: "V2ex",
                                             code: -1,
                                             userInfo: ["Error" : "failed to map object"]))
            }
            .observeOn(MainScheduler.instance)
    }
    
    public func mapObjectArray<T: Mappable>() -> RxSwift.Observable<[T]> {
        return mapJSON()
            .observeOn(ConcurrentDispatchQueueScheduler(globalConcurrentQueueQOS: .background))
            .flatMap { array -> Observable<[T]> in
                if let array = array as? [Any] {
                    return Observable.just(array.flatMap { Mapper<T>().map(JSONObject: $0) })
                }
                return Observable.error(NSError(domain: "V2ex",
                                                code: -1,
                                                userInfo: ["Error" : "failed to map object array"]))
            }
            .observeOn(MainScheduler.instance)
    }
}
