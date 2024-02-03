//
//  WordModel.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 03/02/24.
//

import Foundation

struct WordModel: Codable {
    var word, phonetic: String?
    var phonetics: [Phonetic]?
    var meanings: [Meaning]?
}

// MARK: - Meaning
struct Meaning: Codable {
    var definitions: [Definition]?
}

// MARK: - Definition
struct Definition: Codable {
    var definition, example: String?
}

// MARK: - Phonetic
struct Phonetic: Codable {
    var text: String?
    var audio: String?
}
