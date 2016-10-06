//
//  V2exAppContext.swift
//  V2exLogin
//
//  Created by tripleCC on 10/4/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import Foundation
fileprivate let V2exAccountUsernameKey = "V2exAccountUsernameKey"

class V2exAppContext {
    static let shared = V2exAppContext()
    lazy var account: V2exAccount? = {
        return V2exAccount.readCurrentV2exAccount()
    }()
    
    init() {
        HTTPCookieStorage.shared.cookieAcceptPolicy = .onlyFromMainDocumentDomain
    }
    
    var currentUsername: String? {
        get {
            return UserDefaults.standard.value(forKeyPath: V2exAccountUsernameKey) as? String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKeyPath: V2exAccountUsernameKey)
        }
    }
    
    func saveAccount() {
       account?.save()
    }
    
    func deleteAccount() {
        currentUsername = nil
        account?.delete()
        account = nil
    }
}
