//
//  SearchResultViewController.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 03/02/24.
//

import UIKit

class SearchResultViewController: UIViewController {

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

    }

}
