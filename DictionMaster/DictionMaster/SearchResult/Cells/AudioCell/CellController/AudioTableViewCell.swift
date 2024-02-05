//
//  AudioTableViewCell.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 04/02/24.
//

import UIKit

protocol AudioTableViewCellDelegate: AnyObject {
    func showErrorAlert(error: String)
}

class AudioTableViewCell: UITableViewCell {
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var speakerContainer: UIView!
    @IBOutlet weak var speakerImage: UIImageView!
    @IBOutlet weak var pronunciationLabel: UILabel!
    
    static let identifier: String = String(describing: AudioTableViewCell.self)
    private var viewModel: AudioCellViewModel?
    private var delegate:AudioTableViewCellDelegate?
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        wordLabel.font = .systemFont(ofSize: 45, weight: .bold)
        wordLabel.font.fontDescriptor.withDesign(.rounded)
        wordLabel.textColor = UIColor.countryCollor
        
        speakerContainer.layer.cornerRadius = speakerContainer.frame.size.width / 2
        speakerContainer.layer.masksToBounds = true
        speakerContainer.backgroundColor = UIColor.searchButton
        speakerContainer.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedSpeakerImage))
        speakerContainer.addGestureRecognizer(gesture)
        
        speakerImage.contentMode = .scaleAspectFill
        speakerImage.clipsToBounds = true
        
        pronunciationLabel.font = .systemFont(ofSize: 22, weight: .bold)
        pronunciationLabel.font?.fontDescriptor.withDesign(.rounded)
        pronunciationLabel.textColor = UIColor.placeholderCollor
    }
    
    @objc
    private func tappedSpeakerImage() {
        viewModel?.playDownloadedAudio()
    }
    
    public func setupCell(myWord: WordModel, delegate: AudioTableViewCellDelegate) {
        self.viewModel = AudioCellViewModel(myWord: myWord, delegate: self)
        self.delegate = delegate
        viewModel?.fetchAudio()
        wordLabel.text = viewModel?.getWordText
        pronunciationLabel.text = viewModel?.getWordPhonetic
    }
    
}

extension AudioTableViewCell:AudioCellViewModelDelegate {
    func showErrorAlert(error: String) {
        self.delegate?.showErrorAlert(error: error)
    }
}
