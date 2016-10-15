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
                         _ id: Int? = nil) -> Observable<V2exMember> {
        return V2exProvider
            .request(.ShowMembers(username: username, id: id))
            .mapObject()
            .shareReplay(1)
    }
}
