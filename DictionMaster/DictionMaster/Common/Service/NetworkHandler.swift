//
//  NetworkHandler.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 03/02/24.
//

import Foundation

typealias NetworkResult<T: Decodable> = ((Result<T, NetworkError>) -> Void)

struct NetworkRequest {
    var endpointURL: String
}

enum NetworkError: Error {
    case invalidURL(url: String)
    case networkError(error: Error)
    case invalidResponse
    case invalidStatusCode(statusCode: Int)
    case noData
    case decodeError(error: Error)
}

extension NetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .invalidURL(let url):
            return "Invalid URL: \(url)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .invalidResponse:
            return "Invalid response"
        case .invalidStatusCode(let statusCode):
            return "Invalid status code: \(statusCode)"
        case .noData:
            return "No data found"
        case .decodeError(let error):
            return "Decoding error: \(error.localizedDescription)"
        }
    }

}
