//
//  SearchResultViewController.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 03/02/24.
//

import UIKit

enum SearchViewString: String {
    case alertErrorTitle = "Error"
}

class SearchResultViewController: UIViewController {
    
    @IBOutlet weak var resultTableView: UITableView!
    @IBOutlet weak var topContainer: UIView!
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var speakerContainer: UIView!
    @IBOutlet weak var speakerImage: UIImageView!
    @IBOutlet weak var pronunciationLabel: UILabel!
    @IBOutlet weak var bottonContainer: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var bottonWordLabel: UILabel!
    @IBOutlet weak var newSearchLabel: UILabel!
    @IBOutlet weak var backButtonContainer: UIView!
    @IBOutlet weak var backButtonLabel: UILabel!
    
    
    private var viewModel: SearchResultViewModel
    
    init?(coder: NSCoder, myWord: WordModel) {
        self.viewModel = SearchResultViewModel(myWord: myWord)
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.setupDelegate(delegate: self)
        viewModel.fetchAudio()
        configureNavigation()
        setupTableView()
    }
    
    private func configureNavigation(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    private func setupView() {
        wordLabel.setPrimaryCollorBold(size: 45, text: nil)
        
        speakerContainer.layer.cornerRadius = speakerContainer.frame.size.width / 2
        speakerContainer.layer.masksToBounds = true
        speakerContainer.backgroundColor = UIColor.primaryBlue
        speakerContainer.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedSpeakerImage))
        speakerContainer.addGestureRecognizer(gesture)
        
        speakerImage.contentMode = .scaleAspectFill
        speakerImage.clipsToBounds = true
        wordLabel.text = viewModel.getWordText
        pronunciationLabel.text = viewModel.getWordPhonetic
        pronunciationLabel.setPronunciationStyle()
        
        lineView.backgroundColor = UIColor.lineCollor
        
        bottonWordLabel.setPrimaryCollorBold(size: 24, text: nil)
        bottonWordLabel.text = "That's it for \"\(viewModel.getWord)\"!"
        
        newSearchLabel.setPrimaryCollorRegular(size: 16, text: BackTableViewString.newSearchLabel.rawValue)
        
        backButtonContainer.setButtonStyle()
        let backButtonGesture = UITapGestureRecognizer(target: self, action: #selector(tappedSubscribeButton))
        backButtonContainer.addGestureRecognizer(backButtonGesture)
        
        backButtonLabel.setButtonLabelStyle(text: BackTableViewString.backButtonLabel.rawValue)
    }
    
    private func setupTableView() {
        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.allowsSelection = false
        resultTableView.separatorStyle = .none
        resultTableView.showsVerticalScrollIndicator = false
        resultTableView.register(MeaningTableViewCell.nib(), forCellReuseIdentifier: MeaningTableViewCell.identifier)
    }
    
    @objc
    private func tappedSpeakerImage() {
        viewModel.playDownloadedAudio()
    }
    
    @objc
    private func tappedSubscribeButton(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MeaningTableViewCell.identifier, for: indexPath) as? MeaningTableViewCell
        cell?.setupCell(myWord: viewModel.getMyWord, index: indexPath.row)
        return cell ?? UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getCellSize(width: tableView.frame.size.width, index: indexPath.row)
    }
    
}

//MARK: - BackTableViewCellDelegate
extension SearchResultViewController: BackTableViewCellDelegate {
    func tappedNewSearchButton() {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - AudioTableViewCellDelegate
extension SearchResultViewController: AudioTableViewCellDelegate {
    func showErrorAlert(error: String) {
        Alert.showAlert(on: self, withTitle: SearchViewString.alertErrorTitle.rawValue, message: error, actions: nil)
    }
}

extension SearchResultViewController: SearchResultViewModelDelegate {
    func showAlertError(error: String) {
        
    }
    
    func audioError() {
        speakerContainer.isUserInteractionEnabled = false
        speakerContainer.backgroundColor = .speakerDisable
    }
    
}
