//
//  BackCellViewModel.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 05/02/24.
//

import Foundation

class BackCellViewModel {
    
    var mtWord: WordModel
    
    init(mtWord: WordModel) {
        self.mtWord = mtWord
    }
    
    public var getWord: String {
        mtWord.word ?? ""
    }
    
}
