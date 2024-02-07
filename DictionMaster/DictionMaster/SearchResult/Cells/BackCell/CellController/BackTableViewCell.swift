//
//  BackTableViewCell.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 04/02/24.
//

import UIKit

enum BackTableViewString: String {
    case newSearchLabel = "Try another search now!"
    case backButtonLabel = "NEW SEARCH"
}

protocol BackTableViewCellDelegate: AnyObject {
    func tappedNewSearchButton()
}

class BackTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var newSearchLabel: UILabel!
    @IBOutlet weak var backButtonContainer: UIView!
    @IBOutlet weak var backButtonLabel: UILabel!
    
    
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
        
        wordLabel.setPrimaryCollorBold(size: 24, text: nil)
        
        newSearchLabel.setPrimaryCollorRegular(size: 16, text: BackTableViewString.newSearchLabel.rawValue)
        
        backButtonContainer.setButtonStyle()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedSubscribeButton))
        backButtonContainer.addGestureRecognizer(gesture)
        
        backButtonLabel.setButtonLabelStyle(text: BackTableViewString.backButtonLabel.rawValue)
    }
    
    public func setupDelegate(myWord: WordModel,delegate: BackTableViewCellDelegate) {
        self.viewModel = BackCellViewModel(mtWord: myWord)
        self.delegate = delegate
        wordLabel.text = "That's it for \"\(viewModel?.getWord ?? "")\""
    }
    
    @objc
    private func tappedSubscribeButton(_ sender: Any) {
        delegate?.tappedNewSearchButton()
    }
    
}
