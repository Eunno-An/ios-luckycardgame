//
//  FrontCardView.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/09.
//

import Foundation
import UIKit

class FrontCardView: CardView{
    private var cardAnimal: Animal = .dog
    private var cardNumber: CardNumber = .one
    
    private var cardNumberLabel_up: UILabel = {
        let label = UILabel()
        label.text = "01"
        label.textColor = .black
        return label
    }()
    
    private var cardAnimalLabel: UILabel = {
        let label = UILabel()
        label.text = Animal.dog.rawValue
        return label
    }()
    
    init(frame: CGRect, cardAnimal: Animal, cardNumber: CardNumber) {
        super.init(frame: frame)
        self.cardAnimal = cardAnimal
        self.cardNumber = cardNumber
        
        setCardNumberLabelText(cardNumber)
        setCardAnimalLabelText(cardAnimal)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    private func setupSubviews(){
        setupFrames()
        
        addSubview(cardNumberLabel_up)
        addSubview(cardAnimalLabel)
    }
    
    private func setupFrames(){
        cardNumberLabel_up.frame = CGRect(x: 5, y: 5, width: 40, height: 20)
        
        let animalSize = CGSize(width: 30, height: 30)
        let animalOrigin = CGPoint(x: (bounds.width - animalSize.width) / 2, y : (bounds.height - animalSize.height) / 2)
        cardAnimalLabel.frame = CGRect(origin: animalOrigin, size: animalSize)
        
    }
    
    func setCardNumberLabelText(_ number: CardNumber){
        cardNumberLabel_up.text = String(format: "%02d", number.rawValue)
    }
    
    func setCardAnimalLabelText(_ animal: Animal){
        cardAnimalLabel.text = animal.rawValue
    }
    
}
