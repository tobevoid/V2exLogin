//
//  V2exHTMLParser.swift
//  V2exLogin
//
//  Created by tripleCC on 10/4/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import Foundation
import RxSwift
import Ji

public class V2exHTMLParser {
    static func loginInfoWithHTMLData(data: Data) -> Observable<(String, String, String)> {
        return Observable.of(data)
            .map{Ji(htmlData: $0)}
            .filter{$0 != nil}
            .flatMap{Observable
                .zip($0!.onceToken, $0!.nameKey, $0!.passwordKey)
                {($0, $1, $2)}
        }
    }
}

typealias LoginParser = Ji
extension LoginParser {
    func handleInputAttributesWithFilter(filter:([String : String]) -> Bool, valueKey: String) -> Observable<String> {
        let descendant = self.rootNode?
            .descendantsWithName("input")
            .map{$0.attributes}
            .filter(filter)
            .last
        
        guard let value = descendant?[valueKey] else {
            return Observable.error(RxError.noElements)
        }
        
        return Observable.of(value)
    }
    
    public var onceToken: Observable<String> {
        return handleInputAttributesWithFilter(filter: { $0["name"] == "once" },
                                                          valueKey: "value")
    }
    
    public var nameKey: Observable<String> {
        return handleInputAttributesWithFilter(filter: { $0["type"] == "text" },
                                                          valueKey: "name")
    }
    
    public var passwordKey: Observable<String> {
        return handleInputAttributesWithFilter(filter: { $0["type"] == "password" },
                                                          valueKey: "name")
    }
}
