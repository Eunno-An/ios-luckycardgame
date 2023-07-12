//
//  FrontCardView.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/09.
//

import Foundation
import UIKit

class FrontCardView: CardView{
    typealias CardSize = Constant.CardConstant
    
    private var cardAnimal: Animal = .dog
    private var cardNumber: CardNumber = .one
    
    private var cardNumberLabel_up: UILabel = {
        let label = UILabel()
        label.text = "01"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private var cardNumberLabel_down: UILabel = {
        let label = UILabel()
        label.text = "01"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        //label.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        label.textAlignment = .right
        return label
    }()
    
    private var cardAnimalLabel: UILabel = {
        let label = UILabel()
        label.text = Animal.dog.rawValue
        label.textAlignment = .center
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
        addSubview(cardNumberLabel_down)
        addSubview(cardAnimalLabel)
    }
    
    private func setupFrames(){
        cardNumberLabel_up.frame = CGRect(x: 5, y: 2, width: 30, height: 30)
        cardNumberLabel_down.frame = CGRect(x: CardSize.width - 35, y: CardSize.height - 32, width: 30, height: 30)
        
        let animalSize = CGSize(width: 30, height: 30)
        let animalOrigin = CGPoint(x: (bounds.width - animalSize.width) / 2, y : (bounds.height - animalSize.height) / 2)
        cardAnimalLabel.frame = CGRect(origin: animalOrigin, size: animalSize)
        
    }
    
    func setCardNumberLabelText(_ number: CardNumber){
        cardNumberLabel_up.text = String(format: "%02d", number.rawValue)
        cardNumberLabel_down.text = String(format: "%02d", number.rawValue)
    }
    
    func setCardAnimalLabelText(_ animal: Animal){
        cardAnimalLabel.text = animal.rawValue
    }
    
}
