//
//  MeaningTableViewCell.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 04/02/24.
//

import UIKit

class MeaningTableViewCell: UITableViewCell {
    
    @IBOutlet weak var meaningLabel: UILabel!
    @IBOutlet weak var exampleLabel: UILabel!
    
    static let identifier: String = String(describing: MeaningTableViewCell.self)
    private var viewModel: MeaningTableViewModel?
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        meaningLabel.setPrimaryCollorBold(size: 16, text: nil)
        meaningLabel.numberOfLines = 0

        exampleLabel.setPrimaryCollorRegular(size: 16, text: nil)
        exampleLabel.numberOfLines = 0
    }
    
    public func setupCell(myWord: WordModel, index: Int) {
        viewModel = MeaningTableViewModel(myWord: myWord)
        meaningLabel.text = viewModel?.getMeaningText(index: index)
        exampleLabel.text = viewModel?.getExampleText(index: index)
    }
    
}
