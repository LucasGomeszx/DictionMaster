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
        configureNavigation()
        setupTableView()
    }
    
    private func configureNavigation(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    private func setupTableView() {
        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.allowsSelection = false
        resultTableView.separatorStyle = .none
        resultTableView.register(AudioTableViewCell.nib(), forCellReuseIdentifier: AudioTableViewCell.identifier)
        resultTableView.register(MeaningTableViewCell.nib(), forCellReuseIdentifier: MeaningTableViewCell.identifier)
        resultTableView.register(BackTableViewCell.nib(), forCellReuseIdentifier: BackTableViewCell.identifier)
    }
    
}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AudioTableViewCell.identifier, for: indexPath) as? AudioTableViewCell else {
                return UITableViewCell()
            }
            cell.setupCell(myWord: viewModel.getMyWord, delegate: self)
            return cell
        } else if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BackTableViewCell.identifier, for: indexPath) as? BackTableViewCell else {
                return UITableViewCell()
            }
            cell.setupDelegate(myWord: viewModel.getMyWord,delegate: self)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MeaningTableViewCell.identifier, for: indexPath) as? MeaningTableViewCell else {
                return UITableViewCell()
            }
            cell.setupCell(myWord: viewModel.getMyWord, index: indexPath.row - 1)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return viewModel.getAudioCellSize
        } else if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            return viewModel.getBackCellSize
        } else {
            return viewModel.getCellSize(width: tableView.frame.size.width, index: indexPath.row - 1 )
        }
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
