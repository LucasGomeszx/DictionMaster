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
            return "URL inválida: \(url)"
        case .networkError(let error):
            return "Erro de rede: \(error.localizedDescription)"
        case .invalidResponse:
            return "Resposta inválida"
        case .invalidStatusCode(let statusCode):
            return "Status code inválido: \(statusCode)"
        case .noData:
            return "Dados não encontrados"
        case .decodeError(let error):
            return "Erro de decodificação: \(error.localizedDescription)"
        }
    }
}
