//
//  V2exLoginTests.swift
//  V2exLoginTests
//
//  Created by tripleCC on 10/4/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import XCTest
import Ji
@testable import V2exLogin

class V2exLoginTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func test_AccountKeyChain() {
        let account = V2exAccount(username: "tripleCC", password: "laosiji")
        
        account.save()
        let savedAccount = V2exAccount.readCurrentV2exAccount()
        XCTAssertNotNil(savedAccount)
        XCTAssertEqual(savedAccount!, account)
        
        account.delete()
        XCTAssertNil(V2exAccount.readCurrentV2exAccount())
    }
    
    func test_LoginHTMLParser() {
        let once = "45137"
        let nameKey = "76128590372558502ff2be339c9e3cc39e0c19dd7f6339ca4a668cefb5ef8163"
        let passwordKey = "d09bcdebb3b0e6e6f252a3008f907ac76ba956a795023651148980cf0109fa78"
        let loginPreHTML = "<?xml version='1.0' encoding='UTF-8'?><note><heading>Reminder</heading><body><input type='hidden' value='\(once)' name='once'><input type='password' class='sl' name='\(passwordKey)' value='' autocorrect='off' spellcheck='false' autocapitalize='off'><input type='text' class='sl' name='\(nameKey)' value='' autofocus='autofocus' autocorrect='off' spellcheck='false' autocapitalize='off'></body></note>"
        
        let _ = V2exHTMLParser.loginInfoWithHTML(loginPreHTML.data(using: String.Encoding.utf8)!)
            .subscribe(onNext: { (_once, _nameKey, _passwordKey) in
                XCTAssertEqual(once, _once)
                XCTAssertEqual(nameKey, _nameKey)
                XCTAssertEqual(passwordKey, _passwordKey)
                }, onError: { (error) in
                    XCTAssertNil(error)
            })
    }
    
    func test_Login() {
        let loginManager = V2exLoginManager()
        
        loginManager.account = V2exAccount(username: "kyz001", password: "chixi13506621125")
        let _ = loginManager.login()
            .subscribe(onNext: { (response) in
                XCTAssertEqual(response.statusCode, 200)
                }, onError: { (error) in
                    XCTAssertNil(error)
            })
    }
    
    func test_Logout() {
        let loginManager = V2exLoginManager()
        
        loginManager.logout()
        XCTAssertNil(V2exAppContext.shared.account)
        XCTAssertNil(V2exAppContext.shared.currentUsername)
        XCTAssertNil(V2exAccount.readCurrentV2exAccount())
    }
}
