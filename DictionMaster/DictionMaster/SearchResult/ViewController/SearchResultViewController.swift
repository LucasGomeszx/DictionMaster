//
//  SearchResultViewController.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 03/02/24.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    @IBOutlet weak var resultTableView: UITableView!
    
    var viewModel: SearchResultViewModel
    
    init?(coder: NSCoder, myWord: WordModel) {
        self.viewModel = SearchResultViewModel(myWord: myWord)
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.allowsSelection = false
        resultTableView.separatorStyle = .none
        resultTableView.register(AudioTableViewCell.nib(), forCellReuseIdentifier: AudioTableViewCell.identifier)
        resultTableView.register(MeaningTableViewCell.nib(), forCellReuseIdentifier: MeaningTableViewCell.identifier)
    }

}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel.myWord.meanings?[0].definitions?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AudioTableViewCell.identifier, for: indexPath) as? AudioTableViewCell
            cell?.setupCell(myWord: viewModel.myWord)
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MeaningTableViewCell.identifier, for: indexPath) as? MeaningTableViewCell
            cell?.setupCell(myWord: viewModel.myWord, index: indexPath.row - 1)
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 140
        } else {
            return 300
        }
    }
    
}