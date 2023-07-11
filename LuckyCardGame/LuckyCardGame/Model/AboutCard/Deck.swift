//
//  Deck.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/05.
//

import Foundation

/*
 MARK: Card가 여러장 들어있는 Deck class입니다.
 [LuckyCard]는 값타입이지만 참조타입처럼 작동하기 때문에 class로 Deck을 선정했습니다.
 cards는 Array로 구현했습니다.
 원하는 카드를 뽑는 작업이 다수 필요하다면 Set으로 구현해서 시간복잡도를 줄일 수 있겠지만, 현재 요구사항에서는 카드의 장수가 많지 않아서 linear 자료구조를 채택했습니다.
 
 에러 처리는 setCards에서 던진 에러가 있다면 이를 그대로 받아서 Deck 생성자를 호출한 쪽으로 에러를 던집니다.
 에러를 던지기 전, 카드 배열을 초기화해주는 작업을 수행해야합니다.
 */
class Deck{
    
    private var cards: [LuckyCard]
    
    init() {
        self.cards = []
    }
    convenience init(cards: [LuckyCard]){
        self.init()
        self.cards = cards
    }
    
    public func getCards() -> [LuckyCard]{
        return cards
    }
    
    public func setCards(cards: [LuckyCard]){
        self.cards = cards
    }
}

/*
 MARK: Deck의 Card Array인 cards property인 데이터를 만드는 부분입니다.
 setCards()함수에서 numbers라는 Int Array를 shuffle한 값을 순차탐색하면서,
 각 요소마다 enum Animal에서 랜덤하게 선택한 요소를 매칭시켜 card 하나를 만들고,
 이 card를 Deck의 cards라는 [Int]에 append해주었습니다.
 또한 카드를 만들어주다가 에러가 발생하면 에러 유형에 맞는 에러를 던지도록 구현했습니다.
 */
extension Deck{
    
    func setCards(){
        for _ in 0..<12{
            let luckyCard = LuckyCard(number: CardNumber.allCases.randomElement()!, animal: Animal.allCases.randomElement()!)
            self.cards.append(luckyCard)
        }
    }
    
}
