//
//  SearchResultViewModel.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 03/02/24.
//

import Foundation

class SearchResultViewModel {
    
    private var myWord: WordModel
    
    init(myWord: WordModel) {
        self.myWord = myWord
    }
    
    public var getNumberOfRows: Int {
        (myWord.meanings?[0].definitions?.count ?? 0) + 2
    }
    
    public var getMyWord: WordModel {
        return myWord
    }
    
}
