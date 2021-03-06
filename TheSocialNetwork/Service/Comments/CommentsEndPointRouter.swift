//
//  CommentsEndPointRouter.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 19.01.21.
//

import Foundation

enum CommentsEndPointRouter: EndpointRouter {
    
    case comments
    
    var baseURL: String {
        return Constants.baseURL
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .comments:
            return "comments"
        }
        
    }
    
    
}
