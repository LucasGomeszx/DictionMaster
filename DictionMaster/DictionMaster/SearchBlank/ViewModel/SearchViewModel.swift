//
//  SearchViewModel.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 03/02/24.
//

import Foundation

class SearchViewModel {
    
    public func fetchData(word: String) {
        ServiceManeger.shered.getDictionarySearch(word: word) { (result: Result<[WordModel], Error>) in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}
