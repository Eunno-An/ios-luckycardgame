//
//  Card.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/05.
//

import Foundation

// MARK: Card 프로토콜입니다. 추후 구현사항이 더 있을수도 있어 따로 Protocol을 채택하도록 만들었습니다.
protocol Card{
    var number: Int{get}
    var animal: Animal{get}
}

/*
 MARK: LuckyCard하나의 정보를 표현한 struct입니다. set이 없기 때문에 굳이 class로 만들 이유가 없다고 생각해서 struct를 사용했습니다.
 */
struct LuckyCard: Card, Hashable{
    
    var number: Int
    var animal: Animal
    
    init(number: Int, animal: Animal){
        self.number = number
        self.animal = animal
    }
}

// MARK: LuckyCard의 Validator를 따로 구조체나 클래스 혹은 enum으로 만들기 보다는 extension으로 사용하는게 더 좋은 방법인것 같아서 이렇게 사용했습니다.
extension LuckyCard{
    var isValidNum: Bool{
        return (1...12).contains(number)
    }
    var isValidAnimal: Bool{
        return Animal.allCases.contains(animal)
    }
}

// MARK: LuckyCard에서 발생할 수 있는 Error의 열거형입니다.
enum LuckyCardError: Error{
    case invalidNumber
    case invalidAnimal
}

