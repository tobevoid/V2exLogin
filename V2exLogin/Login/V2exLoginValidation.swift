//
//  V2exLoginValidation.swift
//  V2exLogin
//
//  Created by tripleCC on 10/6/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import Foundation

protocol V2exLoginValidation {
    func validateUsername(_ username: String) -> Bool
    func validatePassword(_ password: String) -> Bool
}

class V2exLoginValidationService: V2exLoginValidation {
    func validateUsername(_ username: String) -> Bool {
        return username.characters.count > 0
    }
    func validatePassword(_ password: String) -> Bool {
        return password.characters.count > 0
    }
}
