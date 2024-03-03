//
//  SearchResultViewModel.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 03/02/24.
//

import Foundation
import UIKit

class SearchResultViewModel {
    
    private var myWord: WordModel
    
    init(myWord: WordModel) {
        self.myWord = myWord
    }
    
    public var getNumberOfRows: Int {
        (myWord.meanings?[0].definitions?.count ?? 0)
    }
    
    public var getMyWord: WordModel {
        return myWord
    }
    
    private func getMeaningSize(width: CGFloat, index: Int) -> CGFloat {
        let text = myWord.meanings?[0].definitions?[index].definition ?? ""
        let font = UIFont.systemFont(ofSize: 16, weight: .bold)
        let estimateHeight = text.heightWithConstrainedWidth(width: width, font: font)
        return estimateHeight
    }    
    
    private func getExampleSize(width: CGFloat, index: Int) -> CGFloat {
        let text = myWord.meanings?[0].definitions?[index].example ?? "Sorry we don't have an example."
        let font = UIFont.systemFont(ofSize: 16, weight: .regular)
        let estimateHeight = text.heightWithConstrainedWidth(width: width, font: font)
        return estimateHeight
    }
    
    public func getCellSize(width: CGFloat, index: Int) -> CGFloat {
        let meaningSize = getMeaningSize(width: width, index: index)
        let exampleSize = getExampleSize(width: width, index: index)
        return meaningSize + exampleSize + 50
    }
    
    public var getAudioCellSize: CGFloat {
        140
    }
    
    public var getBackCellSize: CGFloat {
        200
    }
    
}
