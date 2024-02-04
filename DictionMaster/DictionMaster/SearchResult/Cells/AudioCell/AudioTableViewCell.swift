//
//  AudioTableViewCell.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 04/02/24.
//

import UIKit

class AudioTableViewCell: UITableViewCell {
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var speakerContainer: UIView!
    @IBOutlet weak var speakerImage: UIImageView!
    @IBOutlet weak var pronunciationLabel: UILabel!
    
    static let identifier: String = String(describing: AudioTableViewCell.self)
    
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
        
        speakerImage.contentMode = .scaleAspectFill
        speakerImage.clipsToBounds = true
        
        pronunciationLabel.font = .systemFont(ofSize: 22, weight: .bold)
        pronunciationLabel.font?.fontDescriptor.withDesign(.rounded)
        pronunciationLabel.textColor = UIColor.placeholderCollor
    }
    
    public func setupCell(myWord: WordModel) {
        wordLabel.text = myWord.word?.capitalized ?? ""
        pronunciationLabel.text = myWord.phonetic ?? ""
    }
    
}
