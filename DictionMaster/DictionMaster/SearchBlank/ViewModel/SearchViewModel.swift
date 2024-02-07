//
//  SearchViewModel.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 03/02/24.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func didFetchDataSuccess()
    func showPurchaseScreen()
    func didFetchDataFailure(error: String)
}

class SearchViewModel {
    
    private var delegate: SearchViewModelDelegate?
    private var myWord: WordModel?
    
    public func setViewModelDelegate(delegate: SearchViewModelDelegate) {
        self.delegate = delegate
    }
    
    public func fetchData(word: String) {
        
        if isValidWord(word: word) {
            if let value: WordModel = GenericCache.getValue(forKey: word) {
                self.myWord = value
                self.delegate?.didFetchDataSuccess()
                return
            }
            
            if DailySearchCache.isFreeSearchAvailable() {
                ServiceManeger.shered.getDictionarySearch(word: word) { (result: Result<[WordModel], Error>) in
                    switch result {
                    case .success(let success):
                        self.myWord = success[0]
                        GenericCache.setCache(value: success[0], forKey: word)
                        DailySearchCache.incrementSearchCounter()
                        self.delegate?.didFetchDataSuccess()
                    case .failure(let failure):
                        self.delegate?.didFetchDataFailure(error: failure.localizedDescription)
                    }
                }
            } else {
                self.delegate?.showPurchaseScreen()
            }
        }else {
            self.delegate?.didFetchDataFailure(error: "Invalid word.")
        }
        
    }
    
    private func isValidWord(word: String) -> Bool {
        let nameRegex = "^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
        return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: word)
    }
    
    public var getMyWord: WordModel {
        myWord ?? WordModel()
    }
    
}
