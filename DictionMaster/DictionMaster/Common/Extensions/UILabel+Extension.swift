//
//  UILabel+Extension.swift
//  DictionMaster
//
//  Created by Lucas Gomesx on 05/02/24.
//

import UIKit

extension UILabel {
    
    func setPrimaryCollorRegular(size: CGFloat, text: String?) {
        self.textColor = UIColor.primaryCollor
        self.text = text
        self.font = .systemFont(ofSize: size, weight: .regular)
        self.font.fontDescriptor.withDesign(.rounded)
    }
    
    func setPrimaryCollorBold(size: CGFloat, text: String?) {
        self.textColor = UIColor.primaryCollor
        self.font = .systemFont(ofSize: size, weight: .bold)
        self.font?.fontDescriptor.withDesign(.rounded)
    }
    
    func setPronunciationStyle() {
        self.font = .systemFont(ofSize: 22, weight: .bold)
        self.font?.fontDescriptor.withDesign(.rounded)
        self.textColor = UIColor.placeholderCollor
    }
    
    func setButtonLabelStyle(text: String) {
        self.font = .systemFont(ofSize: 18, weight: .bold)
        self.font.fontDescriptor.withDesign(.rounded)
        self.textColor = UIColor.white
        self.text = text
    }
    
    func setupSubscribeLabel() {
        let texto = "Subscribe now to get unlimited searches and full access to all features."
        
        let atributosGerais: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 20),
            .foregroundColor: UIColor.primaryCollor
        ]
        
        let atributosDiferentes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 20),
            .foregroundColor: UIColor.primaryBlue
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
            .foregroundColor: UIColor.primaryCollor
        ]
        
        let atributosDiferentes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.primaryCollor
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
