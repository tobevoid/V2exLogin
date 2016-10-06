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
    var account: V2exAccount?
    
    // 到时候移到统一的分类里面去
    private func paramsWithUsername(_ username: String, password: String) -> Observable<[String : String]> {
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
    
    private func loginWithUsername(_ username: String, password: String) -> Observable<Response> {
        return paramsWithUsername(username, password: password)
            .retry(1)
            .flatMap {
                V2exProvider
                    .request(.Login(params: $0))
                    .shareReplay(1)
            }
    }
    
    public func login() -> Observable<Response> {
        guard let account = account else { return Observable.empty() }
        
        HTTPCookieStorage.removeAllCookies()
        return loginWithUsername(account.username, password: account.password)
            .filterStatusCode(200)
            .do(onNext: { _ in
                V2exAppContext.shared.account = account
                V2exAppContext.shared.saveAccount()
        })
    }
    
    public func logout() {
        HTTPCookieStorage.removeAllCookies()
        V2exAppContext.shared.deleteAccount()
    }
}

extension HTTPCookieStorage {
    static func removeAllCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date(timeIntervalSince1970: 0))
    }
}
