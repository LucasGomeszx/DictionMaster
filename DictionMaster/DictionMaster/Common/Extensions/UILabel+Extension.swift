//
//  UILabel+Extension.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 05/02/24.
//

import UIKit

extension UILabel {
    
    func setButtonLabelStyle() {
        self.font = .systemFont(ofSize: 18, weight: .bold)
        self.font.fontDescriptor.withDesign(.rounded)
        self.textColor = UIColor.white
    }
    
    func setupSubscribeLabel() {
        let texto = "Subscribe now to get unlimited searches and full access to all features."
        
        let atributosGerais: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 20),
            .foregroundColor: UIColor.countryCollor
        ]
        
        let atributosDiferentes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 20),
            .foregroundColor: UIColor.searchButton
        ]
        
        let textoAtribuido = NSMutableAttributedString(string: texto, attributes: atributosGerais)
        if let rangeUnlimited = texto.range(of: "unlimited") {
            textoAtribuido.setAttributes(atributosDiferentes, range: NSRange(rangeUnlimited, in: texto))
        }
        if let rangeAllFeatures = texto.range(of: "all features.") {
            textoAtribuido.setAttributes(atributosDiferentes, range: NSRange(rangeAllFeatures, in: texto))
        }
        self.attributedText = textoAtribuido
        self.textAlignment = .center
        self.font.fontDescriptor.withDesign(.rounded)
        self.numberOfLines = 0
    }
    
    func setupPurchaseLabel() {
        let texto = "Try 7 Days Free, then only $19,99 per year. Cancel anytime."
        
        let atributosGerais: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
            .foregroundColor: UIColor.countryCollor
        ]
        
        let atributosDiferentes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.countryCollor
        ]
        
        let textoAtribuido = NSMutableAttributedString(string: texto, attributes: atributosGerais)
        if let rangeUnlimited = texto.range(of: "Try 7 Days Free") {
            textoAtribuido.setAttributes(atributosDiferentes, range: NSRange(rangeUnlimited, in: texto))
        }
        if let rangeAllFeatures = texto.range(of: "$19,99") {
            textoAtribuido.setAttributes(atributosDiferentes, range: NSRange(rangeAllFeatures, in: texto))
        }
        self.attributedText = textoAtribuido
        self.textAlignment = .center
        self.font.fontDescriptor.withDesign(.rounded)
        self.numberOfLines = 0
    }
    
}
