//
//  APIClientProtocol.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 18.01.21.
//  
//

import Foundation

typealias ResultHandler<T, Error: Swift.Error> = (Result<T, Error>) -> Void

typealias Parameters = [String: Any]

protocol APIClientProtocol: class {

    var dispatchQueue: DispatchQueue { get }
    var responseQueue: DispatchQueue { get }

    func request<T: Decodable>(
        to endpoint: EndpointRouter,
        parameters: Parameters?,
        decoder: ModelDecoder,
        handler: @escaping ResultHandler<T, APIClientError>)
}

// MARK: - Convenience request methods

extension APIClientProtocol {

    func request<T: Decodable>(
        to endpoint: EndpointRouter,
        decoder: ModelDecoder = JSONDecoder.default,
        handler: @escaping ResultHandler<T, APIClientError>) {

        return self.request(to: endpoint, parameters: nil, decoder: decoder, handler: handler)
    }
    
    
}
