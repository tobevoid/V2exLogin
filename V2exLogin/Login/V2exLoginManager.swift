//
//  V2exLoginManager.swift
//  V2exLogin
//
//  Created by tripleCC on 10/4/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import Foundation
import RxSwift
import Moya

public class V2exLoginManager {
    private func paramsWithUsername(_ username: String, password: String) -> Observable<[String : String]> {
        return V2exProvider
            .request(.LoginPre)
            .shareReplay(1)
            .flatMap{V2exHTMLParser
                .loginInfoWithHTMLData(data: $0.data)
                .map({ (once, nameKey, passwordKey) in
                    return ["once" : once,
                            "next" : "/",
                            nameKey : username,
                            passwordKey : password]
                })}
    }
    
    public func loginWithUsername(_ username: String, password: String) -> Observable<Response> {
        return paramsWithUsername(username, password: password)
            .retry(1)
            .flatMap {
                V2exProvider
                    .request(.Login(params: $0))
                    .shareReplay(1)
            }
            .do(onNext: {
                if $0.statusCode == 200 {
                    V2exAppContext.sharedInstance.account = V2exAccount(username: username, password: password)
                    V2exAppContext.sharedInstance.saveAccount()
                }
            })
    }
}
