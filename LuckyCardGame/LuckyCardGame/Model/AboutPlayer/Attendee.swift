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
enum AttendeeName: String{
    case first = "A"
    case second = "B"
    case third = "C"
    case fourth = "D"
    case fifth = "E"
    static func getPlayerName(attendeeIdx: Int) -> String{
        switch attendeeIdx {
        case 0:
            return AttendeeName.first.rawValue
        case 1:
            return AttendeeName.second.rawValue
        case 2:
            return AttendeeName.third.rawValue
        case 3:
            return AttendeeName.fourth.rawValue
        case 4:
            return AttendeeName.fifth.rawValue
        default:
            return "?"
        }
    }
}
enum AttendeeNum: Int{
    case three = 3
    case four
    case five
    
    static func getPlayerNames(attendeeNum: AttendeeNum) -> [String]{
        switch attendeeNum{
        case .three:
            return ["A", "B", "C"]
        case .four:
            return ["A", "B", "C", "D"]
        case .five:
            return ["A", "B", "C", "D", "E"]
        }
    }
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

class Attendee: AttendeeRule{
    
    //Protocol AttendeeRule stubs
    func flipFirstNumberCard_In_PlayerCards() {
        
        // 가장 왼쪽 숫자가 현재 앞면이 보이는 상태라면 바로 오른쪽 숫자를 터치합니다.
        if deck.getCards().first?.isFlipped == true{
            deck.getCards()[1].flipCard()
        }else{
            deck.getCards().first?.flipCard()
        }
        
    }
    
    func flipLastNumberCard_In_PlayerCards() {
        
        // 가장 오른쪽 숫자가 현재 앞면이 보이는 상태라면, 바로 왼쪽 숫자를 터치합니다.
        if deck.getCards().last?.isFlipped == true{
            deck.getCards()[deck.getCards().count-2].flipCard()
        }else{
            deck.getCards().last?.flipCard()
        }
        
    }
    
    func flipFirstNumberCard_In_the_OtherPlayerCards(attendee: Attendee) {
        
        //가장 왼쪽 숫자가 현재 앞면이 보이는 상태라면 바로 오른쪽 숫자를 터치합니다.
        if attendee.getDeck().getCards().first?.isFlipped == true{
            attendee.getDeck().getCards()[1].flipCard()
        }else{
            attendee.getDeck().getCards().first?.flipCard()
        }
        
    }
    
    func flipLastNumberCard_In_the_OtherPlayerCards(attendee: Attendee) {
        
        // 가장 오른쪽 숫자가 현재 앞면이 보이는 상태라면 바로 왼쪽 숫자를 터치합니다.
        
        if attendee.getDeck().getCards().last?.isFlipped == true{
            attendee.getDeck().getCards()[attendee.getDeck().getCards().count-2].flipCard()
        }
        else{
            attendee.getDeck().getCards().last?.flipCard()
        }
        
    }
    
    func flipCard_In_BottomBoard(bottomLuckyCards: [LuckyCard], bottomLuckyCardIdx: Int) {
        
        bottomLuckyCards[bottomLuckyCardIdx].flipCard()
    }
    
    private var deck: Deck
    
    init(){
        deck = Deck()
    }
    
    init(deck: Deck){
        self.deck = deck
    }
    
    public func getDeck() -> Deck{
        return self.deck
    }
    
    public func setDeck(deck: Deck){
        self.deck = deck
    }
    
    public func sortDeckByNumberASC(){
        deck = Deck(cards: deck.getCards().sorted{
            $0.number.rawValue < $1.number.rawValue
        })
    }
    
    public func sortDeckByNumberDESC(){
        deck = Deck(cards: deck.getCards().sorted{
            $0.number.rawValue > $1.number.rawValue
        })
    }

}
