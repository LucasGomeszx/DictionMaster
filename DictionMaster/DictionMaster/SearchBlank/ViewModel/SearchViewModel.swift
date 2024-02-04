//
//  SearchViewModel.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 03/02/24.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func didFetchData()
    func didFetchDataError()
}

class SearchViewModel {
    
    var delegate: SearchViewModelDelegate?
    var myWord: WordModel?
    
    public func setViewModelDelegate(delegate: SearchViewModelDelegate) {
        self.delegate = delegate
    }
    
    public func fetchData(word: String) {
        ServiceManeger.shered.getDictionarySearch(word: word) { (result: Result<[WordModel], Error>) in
            switch result {
            case .success(let success):
                print(success)
                self.myWord = success[0]
                self.delegate?.didFetchData()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}
