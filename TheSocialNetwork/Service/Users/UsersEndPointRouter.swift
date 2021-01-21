//
//  UsersEndPointRouter.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 19.01.21.
//

import Foundation

enum UsersEndPointRouter: EndpointRouter {
    
    case user(id: Int)
    
    var baseURL: String {
        return Constants.baseURL
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .user(let id):
            return "users/\(id)"
        }
    }
    
    
}
