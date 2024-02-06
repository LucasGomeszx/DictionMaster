//
//  PurchaseViewController.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 05/02/24.
//

import UIKit

class PurchaseViewController: UIViewController {

    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var titleImage: UIImageView!
    @IBOutlet weak var subscribeLabel: UILabel!
    @IBOutlet weak var purchaseLabel: UILabel!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var buttonLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureNavigation()
    }
    
    private func setupView() {
        backImage.contentMode = .scaleAspectFill
        logoImage.contentMode = .scaleAspectFill
        titleImage.contentMode = .scaleAspectFill
        
        subscribeLabel.setupSubscribeLabel()
        purchaseLabel.setupPurchaseLabel()
        
        buttonContainerView.setButtonStyle()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tappedSubscribeButton))
        buttonContainerView.addGestureRecognizer(gesture)
        
        buttonLabel.text = "SUBSCRIBE"
        buttonLabel.setButtonLabelStyle()
    }
    
    private func configureNavigation(){
        navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    @objc
    private func tappedSubscribeButton() {
        navigationController?.popViewController(animated: true)
    }

}
