//
//  APIClient.swift
//  TheSocialNetwork
//
//  Created by Muhammad Arslan Asim on 18.01.21.
//  
//

import Alamofire
import Foundation

final class APIClient: APIClientProtocol {

    // MARK: - Properties

    let dispatchQueue: DispatchQueue
    let responseQueue: DispatchQueue

    private let sessionManager: Session

    // MARK: - Life cycle

    init(dispatchQueue: DispatchQueue, responseQueue: DispatchQueue, timeout: TimeInterval) {

        self.dispatchQueue = dispatchQueue
        self.responseQueue = responseQueue

        let configuration = URLSessionConfiguration.default
        
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.timeoutIntervalForRequest = timeout
        
        // used to reset cache
        UserDefaults.standard.set(Date(), forKey:Constants.cacheTimeKey)
        
        self.sessionManager = Session(configuration: configuration)
    }

    deinit {
        self.sessionManager.session.invalidateAndCancel()
    }

    // MARK: - Requests

    func request<T: Decodable>(
        to endpoint: EndpointRouter,
        parameters: Parameters? = nil,
        decoder: ModelDecoder,
        handler: @escaping ResultHandler<T, APIClientError>) {
        
        self.request(to: endpoint, parameters: parameters) { requestResult in

            let result: Swift.Result<T, APIClientError>

            switch requestResult {
            case .success(let data):

                do {
                    result = .success(try decoder.decode(T.self, from: data))
                } catch {
                    result = .failure(error.asAPIClientError(type: .decoding))
                }
            case .failure(let error):
                result = .failure(error)
            }

            handler(result)
        }
    }

    func request(
        to endpoint: EndpointRouter,
        parameters: Parameters? = nil,
        handler: @escaping ResultHandler<Data, APIClientError>) {
        
        var httpHeaders: HTTPHeaders?
        if let headers = endpoint.httpHeaders {
            httpHeaders = HTTPHeaders(headers)
        }
        
        var requestParameters: Parameters?
        
        if let parameters = parameters {
            requestParameters = parameters
        }
        
        let ecoding: ParameterEncoding = {
            switch endpoint.encoding {
            case .url: return URLEncoding.default
            case .json: return JSONEncoding.default
            }
        }()
        
        self.sessionManager
            .request(endpoint.absolutePath,
                     method: endpoint.method.asHTTPMethod,
                     parameters: requestParameters,
                     encoding: ecoding,
                     headers: httpHeaders)
            .validate()
            .responseData(queue: self.dispatchQueue) { [weak self] in
                self?.handleResponse($0, handler: handler)
            }
    }
    
    // MARK: - Response handling

    private func handleResponse(_ response: DataResponse<Data, AFError>, handler: @escaping ResultHandler<Data, APIClientError>) {

        let result: Swift.Result<Data, APIClientError> = {

            switch response.result {
            case let .success(data):
                return .success(data)
            case .failure:

                let error = APIClientErrorFactory.error(
                    response: response.response,
                    data: response.data,
                    error: response.error)
                
                return .failure(error)
            }
        }()

        self.responseQueue.async {
            handler(result)
        }
    }
    
}

// MARK: - RequestMethod + HTTPMethod

private extension RequestMethod {

    var asHTTPMethod: HTTPMethod {

        switch self {
        case .delete:
            return .delete
        case .get:
            return .get
        case .post:
            return .post
        case .put:
            return .put
        case .patch:
            return .patch
        }
    }
}
