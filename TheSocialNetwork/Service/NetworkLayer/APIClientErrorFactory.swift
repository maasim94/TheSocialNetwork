//
//  APIClientErrorfactory.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 18.01.21.
//  
//

import Foundation

enum APIClientErrorFactory {

    static func error(response: HTTPURLResponse?, data: Data?, error: Error?) -> APIClientError {

        let type = self.errorType(fromResponse: response, error: error)
        let errorJSON = self.errorJSON(fromData: data) ?? [:]

        return APIClientError(type: type, json: errorJSON, error: error)
    }

    private static func errorType(fromResponse response: HTTPURLResponse?, error: Error?) -> APIClientErrorType {

        var errorType: APIClientErrorType = .unknown

        if let statusCode = response?.statusCode {
            errorType = .request(statusCode: statusCode)
        } else if let error = error as? URLError {

            switch error.code {
            case .notConnectedToInternet:
                errorType = .noNetworkConnection
            case .timedOut:
                errorType = .timeout
            case .cancelled:
                errorType = .cancelled
            default:
                errorType = .otherError(code: error.code.rawValue)
            }
        }

        return errorType
    }

    private static func errorJSON(fromData data: Data?) -> Parameters? {

        if let data = data {
            return (try? JSONSerialization.jsonObject(with: data, options: [])) as? Parameters
        } else {
            return nil
        }
    }
}
