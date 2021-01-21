//
//  EndpointRouter.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 18.01.21.
//

import Foundation

enum RequestMethod {
    case get, post, put, delete, patch
}

enum Encoding {

    case url, json
}

protocol EndpointRouter {

    var baseURL: String { get }
    var method: RequestMethod { get }
    var path: String { get }
    var httpHeaders: [String: String]? { get }
    var absolutePath: String { get }
    var encoding: Encoding { get }
}

extension EndpointRouter {

    var httpHeaders: [String: String]? {
        return nil
    }
    
    var absolutePath: String {
        return self.baseURL + self.path
    }

    var encoding: Encoding {
        return .url
    }
    
}
