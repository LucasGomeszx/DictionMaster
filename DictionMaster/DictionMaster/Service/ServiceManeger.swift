//
//  ServiceManeger.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 03/02/24.
//

import Foundation

class ServiceManeger {
    
    let service: Service = Service()
    static let shered = ServiceManeger()
    
    public func getDictionarySearch(word: String, completion: @escaping (Result<[WordModel], Error>) -> Void) {
        
        let request = NetworkRequest(endpointURL: "https://api.dictionaryapi.dev/api/v2/entries/en/\(word)")
        
        service.request(request) { (result : Result<[WordModel], NetworkError>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
}
