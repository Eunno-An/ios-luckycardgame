//
//  Rule.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/11.
//

import Foundation

protocol AttendeeRule{
    func flipFirstNumberCard_In_PlayerCards()
    func flipLastNumberCard_In_PlayerCards()
    
    func flipFirstNumberCard_In_the_OtherPlayerCards(attendee: Attendee)
    func flipLastNumberCard_In_the_OtherPlayerCards(attendee: Attendee)
    
    func flipCard_In_BottomBoard(bottomLuckyCards: [LuckyCard], bottomLuckyCardIdx: Int)
}
