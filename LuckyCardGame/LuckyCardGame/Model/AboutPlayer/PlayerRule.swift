//
//  Rule.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/11.
//

import Foundation

/*
 MARK: 플레이어가 지켜야 하는 룰입니다.
 이 프로토콜을 채택하면, 플레이어는 이 규칙을 지켜야합니다.
 */
protocol PlayerRule{
    func flipFirstNumberCard_In_PlayerCards()
    func flipLastNumberCard_In_PlayerCards()
    
    func flipFirstNumberCard_In_the_OtherPlayerCards(attendee: Attendee)
    func flipLastNumberCard_In_the_OtherPlayerCards(attendee: Attendee)
    
    func flipCard_In_BottomBoard(bottomLuckyCards: [LuckyCard], bottomLuckyCardIdx: Int)
}
