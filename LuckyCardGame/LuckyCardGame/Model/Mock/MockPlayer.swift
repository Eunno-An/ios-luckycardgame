//
//  Mock.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/12.
//

import Foundation

/*
 MARK: 실제 LuckyCardGame와 가장 비슷하게 구현된 수준의 객체인 Mock class를 만들었습니다.
 */
class MockPlayer: Player{
    private(set) var cards: [LuckyCard] = []
    
    init(cards: [LuckyCard]){
        self.cards = cards
    }
    
    func checkThreeNumbersAreInDeck() -> Bool {
        var numCountArr: [Int] = Array(repeating: 0, count: 12)
        
        for card in cards{
            numCountArr[card.number.rawValue] += 1
            if numCountArr[card.number.rawValue] == 3{
                return true
            }
        }
        return false
    }
    
    func sortDeckByNumberASC() {
        cards.sort{
            $0.number.rawValue < $1.number.rawValue
        }
    }
}
