//
//  MeaningTableViewCell.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 04/02/24.
//

import UIKit

class MeaningTableViewCell: UITableViewCell {
    
    @IBOutlet weak var meaningLabel: UILabel!
    @IBOutlet weak var exempleTableView: UITableView!
    
    static let identifier: String = String(describing: MeaningTableViewCell.self)
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        meaningLabel.font = .systemFont(ofSize: 16, weight: .bold)
        meaningLabel.font?.fontDescriptor.withDesign(.rounded)
        meaningLabel.numberOfLines = 0

    }
    
    public func setupCell(myWord: WordModel, index: Int) {
        meaningLabel.text = myWord.meanings?[0].definitions?[index].definition
    }
    
}
