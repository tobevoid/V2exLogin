//
//  V2exLoginViewController.swift
//  V2exLogin
//
//  Created by tripleCC on 10/5/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

class V2exLoginViewController: UIViewController {
    lazy fileprivate var usernameTextField: UITextField = {
        let usernameTextField = UITextField()
        usernameTextField.font = UIFont.systemFont(ofSize: 14)
        usernameTextField.placeholder = "username"
        usernameTextField.textColor = UIColor.black
        usernameTextField.borderStyle = .roundedRect
        return usernameTextField
    }()
    lazy fileprivate var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.font = UIFont.systemFont(ofSize: 14)
        passwordTextField.placeholder = "password"
        passwordTextField.textColor = UIColor.black
        passwordTextField.borderStyle = .roundedRect
        return passwordTextField
    }()
    lazy fileprivate var loginButton: UIButton = {
        let loginButton = UIButton(type: .custom)
        loginButton.backgroundColor = UIColor(red: 123 / 255.0, green: 218 / 255.0, blue: 90 / 255.0, alpha: 1.0)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .highlighted)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return loginButton
    }()
    fileprivate let disposeBag = DisposeBag()
}

extension V2exLoginViewController: V2exViewModelBindable {
    func bindViewModel(_ viewModel: V2exViewModelProtocol?) {
        let viewModel = V2exLoginViewModel(
            username: usernameTextField.rx.text.asObservable(),
            password: passwordTextField.rx.text.asObservable(),
            loginTaps: loginButton.rx.tap.asObservable(),
            validation: V2exLoginValidationService(),
            loginManager: V2exLoginManager()
        )
        
        viewModel.loginEnabled
            .subscribe(onNext: { [weak self] valid in
                self?.loginButton.isEnabled = valid
                self?.loginButton.alpha = valid ? 1.0 : 0.5
                })
            .addDisposableTo(disposeBag)
        
        viewModel.logined
            .subscribe(onNext: {
                print($0)
            })
            .addDisposableTo(disposeBag)
        
        let tapBackground = UITapGestureRecognizer()
        tapBackground.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
                })
            .addDisposableTo(disposeBag)
        view.addGestureRecognizer(tapBackground)
        
        V2exProvider.fetchMemberInfo()
            .subscribe(onNext: {
                print($0)
            })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(loginButton)
        layoutPageSubviews()
        bindViewModel(nil)
    }
}

extension V2exLoginViewController {
    fileprivate func layoutPageSubviews() {
        usernameTextField.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(view).offset(20)
            make.height.equalTo(30)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(usernameTextField)
            make.top.equalTo(usernameTextField.snp.bottom).offset(10)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(passwordTextField)
            make.top.equalTo(passwordTextField.snp.bottom).offset(40)
            make.height.equalTo(40)
        }
    }
}
