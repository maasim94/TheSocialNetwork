//
//  PostsEndPoint.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 18.01.21.
//

import Foundation

enum PostsEndPointRouter: EndpointRouter {
    
    case posts
    
    var baseURL: String {
        return Constants.baseURL
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .posts:
            return "posts"
        }
        
    }
    
    
}
