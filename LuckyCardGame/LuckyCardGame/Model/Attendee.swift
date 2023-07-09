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
    var deck: Deck
    
    init(){
        deck = Deck()
    }
    
    init(deck: Deck){
        self.deck = deck
    }
}
