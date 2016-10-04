//
//  V2exAppContext.swift
//  V2exLogin
//
//  Created by tripleCC on 10/4/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import Foundation

class V2exAppContext {
    static let sharedInstance = V2exAppContext()
    var account: V2exAccount?
    
    init() {
        account = V2exAccount.readCurrentV2exAccount()
        print(self.account)
    }
    
    func saveAccount() {
       account?.save()
    }
    
    func deleteAccount() {
        account?.delete()
    }
}
