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
    
    public func login() -> Observable<Response> {
        guard let account = account else { return Observable.empty() }
        
        HTTPCookieStorage.removeAllCookies()
        return V2exProvider.loginWithUsername(account.username, password: account.password)
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
