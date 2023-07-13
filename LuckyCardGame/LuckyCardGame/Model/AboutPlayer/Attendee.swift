//
//  Attendee.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/06.
//

import Foundation

/*
 MARK: 카드 객체 인스턴스를 소유하는 참가자 구조체
 */
enum AttendeeNum: Int{
    case three = 3
    case four
    case five
    
}

//플레이어 한명당 갖고 있는 카드 개수
enum AttendeeCardNum: Int{
    case threeAttendeeHave = 8
    case fourAttendeeHave = 7
    case fiveAttendeeHave = 6
    static func getAttendeeCardNum(attendeeNum: AttendeeNum) -> AttendeeCardNum{
        switch attendeeNum{
        case .three:
            return threeAttendeeHave
        case .four:
            return fourAttendeeHave
        case .five:
            return fiveAttendeeHave
        }
    }
    
}

//BottomBoard에 한 row당 놓는 카드 개수
enum BottomBoardOneRowCardNum: Int{
    case fiveCardsByOneRow = 5
    case fourCardsByOneRow = 4
    case sixCardsByOneRow = 6
    
    static func getOneRowCardNumByAttendeeNum(attendeeNum: AttendeeNum) -> BottomBoardOneRowCardNum{
        switch attendeeNum{
        case .three:
            return BottomBoardOneRowCardNum.fiveCardsByOneRow
        case .four:
            return BottomBoardOneRowCardNum.fourCardsByOneRow
        case .five:
            return BottomBoardOneRowCardNum.sixCardsByOneRow
        }
    }
}

//플레이어에게 카드 분배하고 남은 개수
enum RemainingCardNum: Int{
    case nine = 9
    case eight = 8
    case six = 6
    
    static func getRemainingCardNumByAttendeeNum(attendeeNum: AttendeeNum) -> RemainingCardNum{
        switch attendeeNum{
        case .three:
            return RemainingCardNum.nine
        case .four:
            return RemainingCardNum.eight
        case .five:
            return RemainingCardNum.six
        }
    }
}

protocol Player{
    
    //MARK: 세개의 카드의 숫자가 똑같은게 주어진 덱에 있는지 확인하는 함수입니다.
    func checkThreeNumbersAreInDeck() -> Bool
    
    //MARK: 카드를 오름차순으로 정렬하는 함수입니다.
    func sortDeckByNumberASC()
    
    /*
     MARK: 상대방의 덱 중 왼쪽의 카드를 뒤집는 함수입니다.
     하위 객체(Attendee)에서 상위 객체의 상태를 바꿔야 하므로, 매개변수로 이를 받았습니다.
     */
    func choiceLeftSideCardOfTheOtherCard(cards: [LuckyCard], playerIdx: Int, luckyCardGame: LuckyCardGame)
    
    /*
     MARK: 상대방의 덱 중 오른쪽의 카드를 뒤집는 함수입니다.
     하위 객체(Attendee)에서 상위 객체의 상태를 바꿔야 하므로, 매개변수로 이를 받았습니다.
     */
    func choiceRightSideCardOfTheOtherCard(cards: [LuckyCard], playerIdx: Int, luckyCardGame: LuckyCardGame)
    
    //MARK: 카드를 한 장 내 덱에 넣는 함수입니다.
    func addCardToMyDeck(card: LuckyCard)
}

class Attendee: Player, PlayerRule{
    
    //Protocol Player stubs
    func addCardToMyDeck(card: LuckyCard){
        deck.appendCard(card: card)
    }
    
    func checkThreeNumbersAreInDeck() -> Bool {
        var numCountArr: [Int] = Array(repeating: 0, count: 12)
        
        for card in deck.cards{
            numCountArr[card.number.rawValue] += 1
            if numCountArr[card.number.rawValue] == 3{
                return true
            }
        }
        return false
    }
    
    func choiceLeftSideCardOfTheOtherCard(cards: [LuckyCard], playerIdx: Int, luckyCardGame: LuckyCardGame){
        if canFlipLeftMostSideCard(){
            cards[0].flipCard()
            luckyCardGame.appendTemporaryChoicedCards(tempChoicedCardInfo: TempChoicedCardInfo(cardIdx: 0, isBottomCardOrPlayerCard: false, playerIdx: playerIdx, card: cards[0]))
        }else{
            if canFlipSecondLeftMostSideCard(){
                cards[1].flipCard()
                luckyCardGame.appendTemporaryChoicedCards(tempChoicedCardInfo: TempChoicedCardInfo(cardIdx: 1, isBottomCardOrPlayerCard: false, playerIdx: playerIdx, card: cards[1]))
            }else{
                //왼쪽 두장이 이미 다 뒤집힌 경우,
                cards[2].flipCard()
                luckyCardGame.appendTemporaryChoicedCards(tempChoicedCardInfo: TempChoicedCardInfo(cardIdx: 2, isBottomCardOrPlayerCard: false, playerIdx: playerIdx, card: cards[2]))
            }
        }
        
        if luckyCardGame.checkThreeCardsInTemporaryChoiceCards(){
            luckyCardGame.sendCardsToFinalResults()
        }
    }
    
    func choiceRightSideCardOfTheOtherCard(cards: [LuckyCard], playerIdx: Int, luckyCardGame: LuckyCardGame) {
        if canFlipRightMostSideCard(){
            cards.last?.flipCard()
            luckyCardGame.appendTemporaryChoicedCards(tempChoicedCardInfo: TempChoicedCardInfo(cardIdx: cards.count-1, isBottomCardOrPlayerCard: false, playerIdx: playerIdx, card: cards.last!))
        }else{
            if canFlipSecnodRightMostSideCard(){
                cards[cards.count-2].flipCard()
                luckyCardGame.appendTemporaryChoicedCards(tempChoicedCardInfo: TempChoicedCardInfo(cardIdx: cards.count-2, isBottomCardOrPlayerCard: false, playerIdx: playerIdx, card: cards.last!))
            }else{
                //오른쪽 두장이 이미 다 뒤집힌 경우,
                cards[cards.count-3].flipCard()
                luckyCardGame.appendTemporaryChoicedCards(tempChoicedCardInfo: TempChoicedCardInfo(cardIdx: cards.count-3, isBottomCardOrPlayerCard: false, playerIdx: playerIdx, card: cards.last!))
            }
        }
        if luckyCardGame.checkThreeCardsInTemporaryChoiceCards(){
            luckyCardGame.sendCardsToFinalResults()
        }
    }
    
    func sortDeckByNumberASC() {
        deck = Deck(cards: deck.cards.sorted{
            $0.number.rawValue < $1.number.rawValue
        })
    }
    
    func canFlipLeftMostSideCard() -> Bool {
        if deck.cards.count < 1 || deck.cards[0].isSideFront == true{
            return false
        }
        else{
            return true
        }
    }

    func canFlipSecondLeftMostSideCard() -> Bool {
        if deck.cards.count < 2 || deck.cards[1].isSideFront == true{
            return false
        }else{
            return true
        }
    }
    
    func canFlipRightMostSideCard() -> Bool{
        if deck.cards.count < 1 || deck.cards.last?.isSideFront == true{
            return false
        }else{
            return true
        }
    }
    
    func canFlipSecnodRightMostSideCard() -> Bool{
        if deck.cards.count < 2 || deck.cards[deck.cards.count-2].isSideFront == true{
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
    
    private(set) var deck: Deck
    
    init(){
        deck = Deck()
    }
    
    init(deck: Deck){
        self.deck = deck
    }
    
    public func setDeck(deck: Deck){
        self.deck = deck
    }
    
    public func sortDeckByNumberDESC(){
        deck = Deck(cards: deck.cards.sorted{
            $0.number.rawValue > $1.number.rawValue
        })
    }

}
