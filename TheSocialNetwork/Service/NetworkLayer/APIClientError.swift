//
//  APIClientError.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 18.01.21.
//  
//

import Foundation

struct APIClientError: Error {

    let type: APIClientErrorType
    let json: Parameters
    let error: Error?
}

extension APIClientError {

    init(type: APIClientErrorType, error: Error?) {
        self.init(type: type, json: [:], error: error)
    }
}

enum APIClientErrorType: Equatable {

    case decoding, responseProcessing, request(statusCode: Int), cancelled, unauthorized, noNetworkConnection, timeout, certificatePinningError, otherError(code: Int), unknown

    var hasTroublesWithConnection: Bool {

        switch self {
        case .noNetworkConnection, .timeout:
            return true
        default:
            return false
        }
    }
}

extension Error {

    func asAPIClientError(type: APIClientErrorType) -> APIClientError {
        return APIClientError(type: type, json: (self as NSError).userInfo, error: self)
    }
}
