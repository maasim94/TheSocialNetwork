//
//  APIClientFactory.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 18.01.21.
//  
//

import Foundation

enum APIClientFactory {

    static var `default`: APIClientProtocol {

        APIClient(
            dispatchQueue: self.defaultDispatchQueue,
            responseQueue: self.defaultResponseQueue,
            timeout: Constants.timeout)
    }

    private static var defaultDispatchQueue: DispatchQueue {

        DispatchQueue(
            label: "\(String(Bundle.main.bundleIdentifier ?? ""))-\(UUID().uuidString)",
            qos: .userInitiated)
    }

    private static var defaultResponseQueue: DispatchQueue {
        .main
    }
}
