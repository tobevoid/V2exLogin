//
//  V2exLoginViewModel.swift
//  V2exLogin
//
//  Created by tripleCC on 10/5/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import Foundation
import RxSwift
import Moya

class V2exLoginViewModel: V2exViewModel {
    
    let validatedUsername: Observable<Bool>
    let validatedPassword: Observable<Bool>
    let loginEnabled: Observable<Bool>
    let logined: Observable<Bool>
    
    init(username: Observable<String>,
         password: Observable<String>,
         loginTaps: Observable<Void>,
         validation: V2exLoginValidation,
         loginManager: V2exLoginManager) {
        
        validatedUsername = username
            .map(validation.validateUsername)
            .shareReplay(1)
        validatedPassword = password
            .map(validation.validatePassword)
            .shareReplay(1)
        
        logined = loginTaps
            .withLatestFrom(Observable.combineLatest(username, password){ ($0, $1) })
            .map { V2exAccount(username: $0.0, password: $0.1) }
            .do(onNext: { loginManager.account = $0 })
            .flatMap {_ in
                return loginManager.login()
                    .map { $0.statusCode == 200 }
                    .catchErrorJustReturn(false)
            }
            .shareReplay(1)
        
        loginEnabled = Observable
            .combineLatest(validatedUsername, validatedPassword) {
                print($0)
                return $0.0 && $0.1
            }
            .distinctUntilChanged()
            .shareReplay(1)
    }
}
