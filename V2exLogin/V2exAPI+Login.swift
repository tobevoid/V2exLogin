//
//  V2exAPI+Login.swift
//  V2exLogin
//
//  Created by tripleCC on 10/13/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import Foundation
import Moya
import RxSwift

extension RxMoyaProvider {
    func paramsWithUsername(_ username: String, password: String) -> Observable<[String : String]> {
        return V2exProvider
            .request(.LoginPre)
            .shareReplay(1)
            .flatMap{V2exHTMLParser
                .loginInfoWithHTMLData($0.data)
                .map({ (once, nameKey, passwordKey) in
                    return ["once" : once,
                            "next" : "/",
                            nameKey : username,
                            passwordKey : password]
                })}
    }
    
    func loginWithUsername(_ username: String, password: String) -> Observable<Response> {
        return paramsWithUsername(username, password: password)
            .retry(1)
            .flatMap {
                V2exProvider
                    .request(.Login(params: $0))
                    .shareReplay(1)
        }
    }
}
