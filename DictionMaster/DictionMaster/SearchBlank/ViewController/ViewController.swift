//
//  ViewController.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 03/02/24.
//

import UIKit

class SearchBlank: UIViewController {
    
    @IBOutlet weak var capsuleView: UIView!
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    var viewModel: SearchViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.setViewModelDelegate(delegate: self)
    }
    
    private func configureView() {
        capsuleView.backgroundColor = UIColor.capsuleCollor
        capsuleView.clipsToBounds = true
        capsuleView.layer.cornerRadius = 20
        
        countryImage.contentMode = .scaleAspectFill
        
        countryLabel.textColor = UIColor.countryCollor
        countryLabel.text = "ENGLISH"
        countryLabel.font = .systemFont(ofSize: 18, weight: .regular)
        countryLabel.font.fontDescriptor.withDesign(.rounded)
        
        searchTextField.delegate = self
        searchTextField.borderStyle = .none
        searchTextField.textColor = UIColor.textFieldCollor
        searchTextField.font = .systemFont(ofSize: 32, weight: .bold)
        searchTextField.font?.fontDescriptor.withDesign(.rounded)
        configurePlaceholderStyle()
        
        searchButton.backgroundColor = UIColor.searchButton
        searchButton.clipsToBounds = true
        searchButton.layer.cornerRadius = 14
        searchButton.setTitle("SEARCH", for: .normal)
        searchButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        searchButton.titleLabel?.font.fontDescriptor.withDesign(.rounded)
        searchButton.setTitleColor(.white, for: .normal)
    }
    
    private func configurePlaceholderStyle() {
        let placeholderText = "Type a word..."
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.placeholderCollor,
            .font: UIFont.systemFont(ofSize: 32, weight: .regular)
        ]
        searchTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
    }

    @IBAction func searchButton(_ sender: Any) {
//        viewModel.fetchData(word: searchTextField.text ?? "")
        let vc: PurchaseViewController? = UIStoryboard(name: "PurchaseView", bundle: nil).instantiateViewController(identifier: "PurchaseView") { coder -> PurchaseViewController? in
            return PurchaseViewController(coder: coder)
        }
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
}

extension SearchBlank: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SearchBlank: SearchViewModelDelegate {
    
    func didFetchData() {
        let vc: SearchResultViewController? = UIStoryboard(name: "SearchResultView", bundle: nil).instantiateViewController(identifier: "SearchResultView") { coder -> SearchResultViewController? in
            return SearchResultViewController(coder: coder, myWord: self.viewModel.myWord ?? WordModel())
        }
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
        searchTextField.text = ""
    }
    
    func didFetchDataError() {
        
    }
    
}
