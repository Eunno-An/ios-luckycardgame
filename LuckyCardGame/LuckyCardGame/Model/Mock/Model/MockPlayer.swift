//
//  MockPlayer.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/13.
//

import Foundation

class MockPlayer: Player, PlayerRule{
    func choiceCardOfTheBottom(bottomCardIdx: Int, bottomCards: [LuckyCard]) {
        //<#code#>
    }
    
    func deleteXthCardInMyDeck(cardIdx: Int) {
        //<#code#>
    }
    
    func addCardToMyDeck(card: LuckyCard) {
        //<#code#>
    }
    
    
    func choiceLeftSideCardOfTheOtherCard(cards: [LuckyCard], playerIdx: Int, luckyCardGame: LuckyCardGame) {
        //
    }
    
    func choiceRightSideCardOfTheOtherCard(cards: [LuckyCard], playerIdx: Int, luckyCardGame: LuckyCardGame) {
        //
    }
    
    
    private(set) var cards: [LuckyCard]
    
    init(){
        cards = []
    }
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
    
    func canFlipLeftMostSideCard() -> Bool {
        if cards.count < 1 || cards[0].isSideFront == true{
            return false
        }
        else{
            return true
        }
    }

    func canFlipSecondLeftMostSideCard() -> Bool {
        if cards.count < 2 || cards[1].isSideFront == true{
            return false
        }else{
            return true
        }
    }
    
    func canFlipRightMostSideCard() -> Bool{
        if cards.count < 1 || cards.last?.isSideFront == true{
            return false
        }else{
            return true
        }
    }
    
    func canFlipSecnodRightMostSideCard() -> Bool{
        if cards.count < 2 || cards[cards.count-2].isSideFront == true{
            return false
        }
        else{
            return true
        }
    }
    
    func canFlipDownSideCard(card: LuckyCard) -> Bool {
        if card.isSideFront == true{
            return false
        }else{
            return true
        }
    }
    
}
