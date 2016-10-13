//
//  V2exAPI.swift
//  V2exLogin
//
//  Created by tripleCC on 10/4/16.
//  Copyright © 2016 tripleCC. All rights reserved.
//

import Foundation
import Moya

let V2exProvider = RxMoyaProvider<V2ex>(manager: customManager())

fileprivate func customManager() -> Manager {
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
    case ShowNodes(name: String)
    case ShowMembers(username: String? , id: String? )
}

extension V2ex : TargetType {
    public var baseURL: URL { return URL(string: "https://www.v2ex.com/")! }
    public var path: String {
        switch self {
        case .LoginPre: fallthrough
        case .Login(_):
            return "signin"
        case .HotTopics:
            return "api/topics/hot.json"
        case .LatestTopics:
            return "api/topics/latest.json"
        case .ShowNodes:
            return "api/nodes/show.json"
        case .ShowMembers:
            return "api/members/show.json"
        }
    }
    public var method: Moya.Method {
        switch self {
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
        case .ShowNodes(let name):
            return ["name" : name]
        case .ShowMembers(let username, let id):
            return username != nil ? ["username" : username!] :
            id != nil ? ["id" : id] : nil
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

