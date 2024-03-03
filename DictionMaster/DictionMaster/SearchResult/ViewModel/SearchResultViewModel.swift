//
//  SearchResultViewModel.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 03/02/24.
//

import Foundation
import UIKit
import AVFoundation

protocol SearchResultViewModelDelegate: AnyObject {
    func showAlertError(error: String)
    func audioError()
}

class SearchResultViewModel {
    
    private var myWord: WordModel
    private var audioData: Data?
    private var audioPlayer: AVAudioPlayer?
    weak var delegate: SearchResultViewModelDelegate?
    
    init(myWord: WordModel) {
        self.myWord = myWord
    }
    
    public func setupDelegate(delegate: SearchResultViewModelDelegate) {
        self.delegate = delegate
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
    
    public var getWord: String {
        myWord.word ?? ""
    }
    
}

//MARK: - TopContainer
extension SearchResultViewModel {
    
    public var getAudioUrl: String {
        myWord.phonetics?[0].audio ?? ""
    }
    
    public var getWordText: String {
        self.myWord.word?.capitalized ?? ""
    }
    
    public var getWordPhonetic: String {
        self.myWord.phonetic ?? ""
    }
    
    public func fetchAudio() {
        ServiceManeger.shered.dowloadAudio(audioUrl: getAudioUrl) { (result: Result<Data, Error>) in
            switch result {
            case .success(let success):
                self.audioData = success
            case .failure(_):
                self.delegate?.audioError()
            }
        }
    }
    
    public func playDownloadedAudio() {
        guard let audioData = audioData else {
            self.delegate?.showAlertError(error: "Audio indisponivel.")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: audioData)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch _ as NSError {
            self.delegate?.showAlertError(error: "Audio indisponivel.")
        }
    }
    
}
