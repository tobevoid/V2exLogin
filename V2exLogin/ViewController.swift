//
//  ViewController.swift
//  V2exLogin
//
//  Created by tripleCC on 10/4/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Ji

class ViewController: UIViewController {
    let disposeBag = DisposeBag()
    let manager = V2exLoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.account = V2exAccount(username: "kyz001", password: "chixi13506621125")
        manager.login()
            .subscribe(onNext: {
                print($0)
                }, onError: {
                    print($0)
            })
            .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

