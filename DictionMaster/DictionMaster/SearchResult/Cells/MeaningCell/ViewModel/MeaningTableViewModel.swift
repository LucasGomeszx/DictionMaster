//
//  MeaningTableViewModel.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 04/02/24.
//

import Foundation

class MeaningTableViewModel {
    
    private var myWord: WordModel
    
    init(myWord: WordModel) {
        self.myWord = myWord
    }
    
    public func getMeaningText(index: Int) -> String {
        let definition = myWord.meanings?[0].definitions?[index].definition ?? "No definition available"
        return "\(index + 1)) \(definition)"
    }
    
    public func getExampleText(index: Int) -> String {
        let exampleText = myWord.meanings?[0].definitions?[index].example ?? "Sorry we don't have an example."
        
        let words = exampleText.components(separatedBy: " ")
        if var firstWord = words.first {
            firstWord.replaceSubrange(firstWord.startIndex...firstWord.startIndex, with: String(firstWord[firstWord.startIndex].uppercased()))
            return "• \(words.dropFirst().reduce(firstWord) { $0 + " " + $1 })"
        }
        
        return exampleText
    }
    
}
