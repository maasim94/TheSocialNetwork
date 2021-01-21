//
//  PostService.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 18.01.21.
//

import Foundation

protocol PostsServiceProtocol {

    typealias PostsCompletion = (Result<[Post], APIClientError>) -> Void

    func getPosts(of page: Int, handler: @escaping PostsCompletion)
}

final class PostsService {

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

extension PostsService: PostsServiceProtocol {
    
    func getPosts(of page: Int, handler: @escaping PostsCompletion) {
        
        let router = PostsEndPointRouter.posts
        let param: Parameters = ["_page" :page]
        self.dependency.networkLayer.request(to: router, parameters: param, decoder: JSONDecoder.default, handler: handler)
    }
}
