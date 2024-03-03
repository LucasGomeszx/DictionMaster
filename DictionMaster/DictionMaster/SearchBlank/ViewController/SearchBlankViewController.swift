//
//  ViewController.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 03/02/24.
//

import UIKit

enum SearchBlankString: String {
    case alertErrorTitle = "Error"
    case countryLabelText = "ENGLISH"
    case searchContainerLabel = "SEARCH"
    case placeholderText = "Type a word..."
    case searchResultView = "SearchResultView"
    case purchaseView = "PurchaseView"
}

class SearchBlankViewController: UIViewController {
    
    @IBOutlet weak var capsuleView: UIView!
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchContainer: UIView!
    @IBOutlet weak var searchContainerLabel: UILabel!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var loadingView: UIView!
    
    private var viewModel: SearchViewModel = SearchViewModel()
    private let spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigation()
        configNotification()
        hideKeyboardWhenTapped()
        viewModel.setViewModelDelegate(delegate: self)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupView() {
        loadingView.isHidden = true
        loadingView.backgroundColor = .loadingBackCollor
        
        capsuleView.backgroundColor = UIColor.capsuleCollor
        capsuleView.clipsToBounds = true
        capsuleView.layer.cornerRadius = 20
        
        countryImage.contentMode = .scaleAspectFill
        
        countryLabel.setPrimaryCollorRegular(size: 18, text: SearchBlankString.countryLabelText.rawValue)
        
        searchTextField.delegate = self
        searchTextField.borderStyle = .none
        searchTextField.autocorrectionType = .no
        searchTextField.textColor = UIColor.primaryCollor
        searchTextField.font = .systemFont(ofSize: 32, weight: .bold)
        searchTextField.font?.fontDescriptor.withDesign(.rounded)
        configurePlaceholderStyle()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedSearchButton))
        searchContainer.addGestureRecognizer(gesture)
        searchContainer.setButtonStyle()
        
        searchContainerLabel.setButtonLabelStyle(text: SearchBlankString.searchContainerLabel.rawValue)
        
        setupLoadingIndicator()
    }
    
    private func configurePlaceholderStyle() {
        let placeholderText = SearchBlankString.placeholderText.rawValue
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.placeholderCollor,
            .font: UIFont.systemFont(ofSize: 32, weight: .regular)
        ]
        searchTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
    }

    private func setupLoadingIndicator() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        loadingView.addSubview(spinner)

        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func showLoading() {
        loadingView.isHidden = false
        spinner.startAnimating()
    }

    private func hideLoading() {
        loadingView.isHidden = true
        spinner.stopAnimating()
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func configNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            buttonBottomConstraint.constant = keyboardSize.height - 24
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        buttonBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.25) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    private func tappedSearchButton() {
        showLoading()
        viewModel.fetchData(word: searchTextField.text?.lowercased() ?? "")
    }
    
}

//MARK: - UITextFieldDelegate
extension SearchBlankViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: -SearchViewModelDelegate
extension SearchBlankViewController: SearchViewModelDelegate {
    func didFetchDataSuccess() {
        hideLoading()
        let vc: SearchResultViewController? = UIStoryboard(name: SearchBlankString.searchResultView.rawValue, bundle: nil).instantiateViewController(identifier: SearchBlankString.searchResultView.rawValue) { coder -> SearchResultViewController? in
            return SearchResultViewController(coder: coder, myWord: self.viewModel.getMyWord)
        }
        navigationController?.pushViewController(vc ?? UIViewController(), animated: true)
        searchTextField.text = ""
    }
    
    func showPurchaseScreen() {
        hideLoading()
        guard let purchaseVC = UIStoryboard(name: SearchBlankString.purchaseView.rawValue, bundle: nil).instantiateViewController(withIdentifier: SearchBlankString.purchaseView.rawValue) as? PurchaseViewController else {
            return
        }
        purchaseVC.modalPresentationStyle = .fullScreen
        present(purchaseVC, animated: true, completion: nil)
    }
    
    func didFetchDataFailure(error: String) {
        hideLoading()
        Alert.showAlert(on: self, withTitle: SearchBlankString.alertErrorTitle.rawValue, message: error, actions: nil)
    }
}
