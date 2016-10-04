//
//  V2exAPI.swift
//  V2exLogin
//
//  Created by tripleCC on 10/4/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import Foundation
import Moya

let V2exProvider = RxMoyaProvider<V2ex>(manager: manager())

func manager() -> Manager {
    var defaultHTTPHeaders = Manager.defaultHTTPHeaders
    defaultHTTPHeaders["Referer"] = "https://v2ex.com/signin"
    
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = defaultHTTPHeaders
    let manager = Manager(configuration: configuration)
    manager.startRequestsImmediately = false
    
    return manager
}

public enum V2ex {
    case LoginPre
    case Login(params: [String : String])
    case HotTopics
    case LatestTopics
    case ShowNodes
    case ShowMembers
}

extension V2ex : TargetType {
    public var baseURL: URL { return URL(string: "https://www.v2ex.com/")! }
    public var path: String {
        switch self {
        case .LoginPre:
            fallthrough
        case .Login(_):
            return "signin"
        case .HotTopics:
            return ""
        default:
            return "laosiji"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .LoginPre:
            return .GET
        case .Login(_):
            return .POST
        default:
            return .GET
        }
    }
    public var parameters: [String : Any]? {
        switch self {
        case .Login(let params):
            return params
        default:
            return nil
        }
    }
    
    public var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        return .request
    }
}

