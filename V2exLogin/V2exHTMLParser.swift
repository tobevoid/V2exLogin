//
//  V2exHTMLParser.swift
//  V2exLogin
//
//  Created by tripleCC on 10/4/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Ji

public class V2exHTMLParser: Ji {
    static func loginInfoWithHTMLData(_ data: Data) -> Observable<(String, String, String)> {
        return Observable.of(V2exHTMLParser(htmlData: data))
            .filter{$0 != nil}
            .flatMap{Observable
                .zip($0!.onceToken, $0!.nameKey, $0!.passwordKey)
                {($0, $1, $2)}
        }
    }
}

extension V2exHTMLParser {
    var onceToken: Observable<String> {
        return handleInputAttributesWithFilter({ $0["name"] == "once" },
                                                    valueKey: "value")
    }
    
    var nameKey: Observable<String> {
        return handleInputAttributesWithFilter({ $0["type"] == "text" },
                                                    valueKey: "name")
    }
    
    var passwordKey: Observable<String> {
        return handleInputAttributesWithFilter({ $0["type"] == "password" },
                                                    valueKey: "name")
    }
}

extension JiNode {
    func descendantWithName(_ name: String, attribute:String, value: String) -> JiNode? {
        return descendantsWithName("a").filter{ $0.attributes["href"] == "/member/kyz001" }.last
    }
}

// Confirm to ReactiveCompatible would cause compiling error when building V2exLoginTest, but V2exLogin not.
// Having no idea about that.
// Redundant conformance of 'Ji' to protocol 'ReactiveCompatible'
extension V2exHTMLParser {
    func handleInputAttributesWithFilter(_ filter:([String : String]) -> Bool, valueKey: String) -> Observable<String> {
        let descendant = rootNode?
            .descendantsWithName("input")
            .map{$0.attributes}
            .filter(filter)
            .last
        
        guard let value = descendant?[valueKey] else {
            return Observable.error(RxError.noElements)
        }
        
        return Observable.of(value)
    }
}
