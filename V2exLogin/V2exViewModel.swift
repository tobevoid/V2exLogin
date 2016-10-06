//
//  V2exViewModel.swift
//  V2exLogin
//
//  Created by tripleCC on 10/5/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import Foundation
import RxSwift

class V2exViewModel: V2exViewModelProtocol {
    var disposeBag = DisposeBag()
}

protocol V2exViewModelProtocol {
    var disposeBag: DisposeBag {get set}
}

protocol V2exViewModelBindable {
    func bindViewModel(_ viewModel: V2exViewModelProtocol?)
}
