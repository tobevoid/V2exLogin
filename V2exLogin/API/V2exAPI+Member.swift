//
//  V2exAPI+Member.swift
//  V2exLogin
//
//  Created by tripleCC on 10/13/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import Foundation
import Moya
import RxSwift

extension RxMoyaProvider {
    func fetchMemberInfo(_ username: String? = V2exAppContext.shared.currentUsername,
                         _ id: String? = "") -> Observable<V2exMember> {
        return V2exProvider
            .request(.ShowMembers(username: username, id: id))
            .retry(1)
            .mapObject()
            .shareReplay(1)
    }
}
