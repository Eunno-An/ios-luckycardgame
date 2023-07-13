//
//  CardMock.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/12.
//

import Foundation

protocol CardMock{
    var number: CardNumber{get}
    var animal: Animal{get}
    var isFlipped: Bool { get }
}

class LuckyCardMock: CardMock, Equatable{
    
    private(set) var number: CardNumber
    private(set) var animal: Animal
    private(set) var isFlipped: Bool
    
    static func == (lhs: LuckyCardMock, rhs: LuckyCardMock) -> Bool{
        return lhs.number == rhs.number && rhs.animal == rhs.animal
    }
    
    var describe: String{
        return "\(animal.rawValue)" + String(format:"%02d", number.rawValue)
    }
    
    init(number: CardNumber, animal: Animal, isFlipped: Bool = false){
        self.number = number
        self.animal = animal
        self.isFlipped = isFlipped
    }
    
    public func setNumber(number: CardNumber){
        self.number = number
    }
    
    public func setAnimal(animal: Animal){
        self.animal = animal
    }
    
    public func flipCard(){
        self.isFlipped = !self.isFlipped
    }
}
