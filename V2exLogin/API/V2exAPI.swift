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
    case Topics(nodeId: Int?, nodeName: String?, username: String?, page: Int)
    case HotTopics
    case LatestTopics
    case ShowNodes(name: String)
    case AllNodes
    case ShowMembers(username: String? , id: Int? )
    case Replies(topicId: Int)
    case Reply(topicId: Int, content: String)
}

extension V2ex : TargetType {
    public var baseURL: URL { return URL(string: "https://www.v2ex.com/")! }
    public var path: String {
        switch self {
        case .LoginPre: fallthrough
        case .Login:
            return "signin"
        case .Topics:
            return "api/topics/show.json"
        case .HotTopics:
            return "api/topics/hot.json"
        case .LatestTopics:
            return "api/topics/latest.json"
        case .ShowNodes:
            return "api/nodes/show.json"
        case .AllNodes:
            return "api/nodes/all.json"
        case .ShowMembers:
            return "api/members/show.json"
        case .Replies:
            return "api/replies/show.json"
        case .Reply(let topicId):
            return "t/\(topicId)"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .Login: fallthrough
        case .Reply:
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
            if let username = username {
                return ["username" : username]
            } else if let id = id {
                return ["id" : id]
            }
            return nil
        case .Topics(let nodeId, let nodeName, let username, let page):
            var params: [String : Any] = ["p" : page]
            if let nodeId = nodeId {
                params["node_id"] = nodeId
            } else if let nodeName = nodeName {
                params["node_name"] = nodeName
            } else if let username = username {
                params["username"] = username
            }
            return params
        case .Replies(let topicId):
            return ["topic_id" : topicId]
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

