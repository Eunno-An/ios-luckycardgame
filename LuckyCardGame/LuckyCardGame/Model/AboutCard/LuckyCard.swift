//
//  Card.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/05.
//

import Foundation

// MARK: Card 프로토콜입니다. 추후 구현사항이 더 있을수도 있어 따로 Protocol을 채택하도록 만들었습니다.
protocol Card{
    var number: CardNumber{get}
    var animal: Animal{get}
}

/*
 MARK: LuckyCard하나의 정보를 표현한 struct입니다. set이 없기 때문에 굳이 class로 만들 이유가 없다고 생각해서 struct를 사용했습니다.
 */
struct LuckyCard: Card, Hashable, Equatable{
    
    static func == (lhs: LuckyCard, rhs: LuckyCard) -> Bool {
        return lhs.number == rhs.number && lhs.animal == rhs.animal
    }
    
    private(set) var number: CardNumber
    private(set) var animal: Animal
    private(set) var isFlipped: Bool
    var describe: String{
        return "\(animal.rawValue)" + String(format:"%02d", number.rawValue)
    }
    
    init(number: CardNumber, animal: Animal, isFlipped: Bool = false){
        self.number = number
        self.animal = animal
        self.isFlipped = isFlipped
    }
    
    public mutating func setNumber(number: CardNumber){
        self.number = number
    }
    
    public mutating func setAnimal(animal: Animal){
        self.animal = animal
    }
    
    public mutating func flipCard(){
        self.isFlipped = !self.isFlipped
    }
}

