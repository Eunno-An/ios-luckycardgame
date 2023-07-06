//
//  LuckyCardGame.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/07.
//

import Foundation

// MARK: LuckyCardGame을 즐겨주셔서 감사합니다.
class LuckyCardGame{
    var attendees: [Attendee]
    var cardDealer: CardDealer
    
    init(){
        attendees = []
        cardDealer = CardDealer()
    }
}
