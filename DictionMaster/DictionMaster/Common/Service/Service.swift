//
//  Service.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 03/02/24.
//

import Foundation

protocol ServiceProtocol {
    func request<T: Decodable>(_ request: NetworkRequest, completion: @escaping NetworkResult<T>)
}

class Service: ServiceProtocol {
    
    func request<T: Decodable>(_ request: NetworkRequest, completion: @escaping NetworkResult<T>) {
        
        guard let url = URL(string: request.endpointURL) else {
            completion(.failure(NetworkError.invalidURL(url: request.endpointURL)))
            return
        }
        
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(NetworkError.networkError(error: error)))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }
                
                guard (200..<300).contains(response.statusCode) else {
                    completion(.failure(NetworkError.invalidStatusCode(statusCode: response.statusCode)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(NetworkError.decodeError(error: error)))
                }
            }
            
        }
        session.resume()
    }
    
    func downloadAudioFromURL(urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL(url: urlString)))
            return
        }
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.invalidResponse))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
    
}
