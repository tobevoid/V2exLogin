//
//  V2exAccount.swift
//  V2exLogin
//
//  Created by tripleCC on 10/4/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import Foundation
import Locksmith

fileprivate let V2exAccountUsernameKey = "V2exAccountUsernameKey"

struct V2exAccount: ReadableSecureStorable, CreateableSecureStorable, DeleteableSecureStorable, GenericPasswordSecureStorable{
    let username: String
    let password: String
    
    let service = "V2ex"
    var account: String { return username }
    var data: [String: Any] {
        return ["password": password]
    }
    
    init(username: String, password: String = "") {
        self.username = username
        self.password = password
    }
}

extension V2exAccount: Equatable {
    public static func ==(lhs: V2exAccount, rhs: V2exAccount) -> Bool {
        return lhs.username == rhs.username &&
        lhs.password == rhs.password &&
        lhs.service == rhs.service
    }
}

extension V2exAccount {
    static func readCurrentV2exAccount() -> V2exAccount? {
        let account = UserDefaults.standard.value(forKeyPath: V2exAccountUsernameKey)
            .flatMap{ $0 as? String }
            .map{ ($0, V2exAccount(username: $0).readFromSecureStore()?.data?["password"])}
            .map{ V2exAccount(username: $0, password: $1 as? String ?? "") }
        
        guard account?.password.characters.count != 0 else { return nil }
        return account
    }
    
    func save() {
        guard password.characters.count > 0 else { return }
        
        UserDefaults.standard.setValue(username, forKeyPath: V2exAccountUsernameKey)
        
        do {
            try createInSecureStore()
        } catch _ {
            do {
                try updateInSecureStore()
            } catch let error {
                print("failed to save account to keychain with error: \(error)")
            }
        }
    }
    
    func delete() {
        do {
            try deleteFromSecureStore()
        } catch let error {
            print("failed to delete account from keychain with error: \(error)")
        }
    }
}

