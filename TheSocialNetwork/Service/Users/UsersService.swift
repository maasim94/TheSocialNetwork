//
//  UsersService.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 19.01.21.
//

import Foundation

protocol UserServiceProtocol {

    typealias UserCompletion = (Result<User, APIClientError>) -> Void

    func getUser(of id: Int, handler: @escaping UserCompletion)
}

final class UserService {

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

extension UserService: UserServiceProtocol {
    
    func getUser(of id: Int, handler: @escaping UserCompletion) {
        
        let router = UsersEndPointRouter.user(id: id)
        self.dependency.networkLayer.request(to: router, handler: handler)
    }
    
}
