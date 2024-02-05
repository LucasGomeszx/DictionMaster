//
//  BackTableViewCell.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 04/02/24.
//

import UIKit

protocol BackTableViewCellDelegate: AnyObject {
    func tappedNewSearchButton()
}

class BackTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var newSearchLabel: UILabel!
    @IBOutlet weak var newSearchButton: UIButton!
    
    static let identifier: String = String(describing: BackTableViewCell.self)
    
    private var viewModel: BackCellViewModel?
    private var delegate: BackTableViewCellDelegate?
    
    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        lineView.backgroundColor = UIColor.lineCollor
        
        wordLabel.font = .systemFont(ofSize: 24, weight: .bold)
        wordLabel.font.fontDescriptor.withDesign(.rounded)
        wordLabel.textColor = UIColor.countryCollor
        
        newSearchLabel.font = .systemFont(ofSize: 16, weight: .regular)
        newSearchLabel.font.fontDescriptor.withDesign(.rounded)
        newSearchLabel.textColor = UIColor.countryCollor
        newSearchLabel.text = "Try another search now!"
        
        newSearchButton.backgroundColor = UIColor.searchButton
        newSearchButton.clipsToBounds = true
        newSearchButton.layer.cornerRadius = 14
        newSearchButton.setTitle("NEW SEARCH", for: .normal)
        newSearchButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        newSearchButton.titleLabel?.font.fontDescriptor.withDesign(.rounded)
        newSearchButton.setTitleColor(.white, for: .normal)
    }
    
    public func setupDelegate(myWord: WordModel,delegate: BackTableViewCellDelegate) {
        self.viewModel = BackCellViewModel(mtWord: myWord)
        self.delegate = delegate
        wordLabel.text = "That's it for \"\(viewModel?.getWord ?? "")\""
    }
    
    @IBAction func newSearchButton(_ sender: Any) {
        delegate?.tappedNewSearchButton()
    }
    
}
