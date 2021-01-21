//
//  CommentsService.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 19.01.21.
//

import Foundation

protocol CommentsServiceProtocol {

    typealias CommentsCompletion = (Result<[Comment], APIClientError>) -> Void

    func getComments(for postid: Int, handler: @escaping CommentsCompletion)
}

final class CommentsService {

    struct Dependency {
        let networkLayer: APIClient
    }

    // MARK: - Properties

    private let dependency: Dependency

    // MARK: - Initialization

    required init(dependency: Dependency = .init(networkLayer: APIClient(dispatchQueue: APIClientFactory.default.dispatchQueue,
                                                                         responseQueue: APIClientFactory.default.responseQueue,
                                                                         timeout: Constants.timeout))) {
        self.dependency = dependency
    }
}

extension CommentsService: CommentsServiceProtocol {
    
    func getComments(for postid: Int, handler: @escaping CommentsCompletion) {
        
        let router = CommentsEndPointRouter.comments
        let param: Parameters = ["postId" :postid]
        self.dependency.networkLayer.request(to: router, parameters: param, decoder: JSONDecoder.default, handler: handler)
    }
    
}
