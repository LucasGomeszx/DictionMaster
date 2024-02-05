//
//  AudioCellViewModel.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 04/02/24.
//

import Foundation
import AVFoundation

protocol AudioCellViewModelDelegate: AnyObject {
    func showErrorAlert(error: String)
}

class AudioCellViewModel {
    
    private var myWord: WordModel
    private var audioData: Data?
    private var audioPlayer: AVAudioPlayer?
    private var delegate:AudioCellViewModelDelegate?
    
    init(myWord: WordModel, delegate: AudioCellViewModelDelegate) {
        self.delegate = delegate
        self.myWord = myWord
    }
    
    public var getAudioUrl: String {
        myWord.phonetics?[0].audio ?? ""
    }
    
    public func fetchAudio() {
        ServiceManeger.shered.dowloadAudio(audioUrl: getAudioUrl) { (result: Result<Data, Error>) in
            switch result {
            case .success(let success):
                self.audioData = success
            case .failure(_):
                break
            }
        }
    }
    
    public func playDownloadedAudio() {
        guard let audioData = audioData else {
            self.delegate?.showErrorAlert(error: "Audio indisponivel.")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: audioData)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch _ as NSError {
            self.delegate?.showErrorAlert(error: "Audio indisponivel.")
        }
    }
    
}
