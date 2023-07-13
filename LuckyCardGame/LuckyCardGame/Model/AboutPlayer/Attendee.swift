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
    
}

class Attendee: Player, AttendeeRule{
    
    //Protocol Player stubs
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
    
    func sortDeckByNumberASC() {
        deck = Deck(cards: deck.cards.sorted{
            $0.number.rawValue < $1.number.rawValue
        })
    }
    
    //Protocol AttendeeRule stubs
    func flipFirstNumberCard_In_PlayerCards() {
        
        // 가장 왼쪽 숫자가 현재 앞면이 보이는 상태라면 바로 오른쪽 숫자를 터치합니다.
        if deck.cards.first?.isFlipped == true{
            deck.cards[1].flipCard()
        }else{
            deck.cards.first?.flipCard()
        }
        
    }
    
    func flipLastNumberCard_In_PlayerCards() {
        
        // 가장 오른쪽 숫자가 현재 앞면이 보이는 상태라면, 바로 왼쪽 숫자를 터치합니다.
        if deck.cards.last?.isFlipped == true{
            deck.cards[deck.cards.count-2].flipCard()
        }else{
            deck.cards.last?.flipCard()
        }
        
    }
    
    func flipFirstNumberCard_In_the_OtherPlayerCards(attendee: Attendee) {
        
        //가장 왼쪽 숫자가 현재 앞면이 보이는 상태라면 바로 오른쪽 숫자를 터치합니다.
        if attendee.deck.cards.first?.isFlipped == true{
            attendee.deck.cards[1].flipCard()
        }else{
            attendee.deck.cards.first?.flipCard()
        }
        
    }
    
    func flipLastNumberCard_In_the_OtherPlayerCards(attendee: Attendee) {
        
        // 가장 오른쪽 숫자가 현재 앞면이 보이는 상태라면 바로 왼쪽 숫자를 터치합니다.
        
        if attendee.deck.cards.last?.isFlipped == true{
            attendee.deck.cards[attendee.deck.cards.count-2].flipCard()
        }
        else{
            attendee.deck.cards.last?.flipCard()
        }
        
    }
    
    func flipCard_In_BottomBoard(bottomLuckyCards: [LuckyCard], bottomLuckyCardIdx: Int) {
        
        bottomLuckyCards[bottomLuckyCardIdx].flipCard()
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
