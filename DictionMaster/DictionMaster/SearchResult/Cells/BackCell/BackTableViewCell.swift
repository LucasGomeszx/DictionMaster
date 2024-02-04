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
    
    var delegate: BackTableViewCellDelegate?
    
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
        
        newSearchButton.backgroundColor = UIColor.searchButton
        newSearchButton.clipsToBounds = true
        newSearchButton.layer.cornerRadius = 14
        newSearchButton.setTitle("SEARCH", for: .normal)
        newSearchButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        newSearchButton.titleLabel?.font.fontDescriptor.withDesign(.rounded)
        newSearchButton.setTitleColor(.white, for: .normal)
    }
    
    public func setupDelegate(delegate: BackTableViewCellDelegate) {
        self.delegate = delegate
    }
    
    @IBAction func newSearchButton(_ sender: Any) {
        delegate?.tappedNewSearchButton()
    }
    
}
