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
}

//플레이어에게 카드 분배하고 남은 개수
enum RemainingCardNum: Int{
    case nine = 9
    case eight = 8
    case six = 6
}

struct Attendee{
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
    
    public mutating func setDeck(deck: Deck){
        self.deck = deck
    }
}
