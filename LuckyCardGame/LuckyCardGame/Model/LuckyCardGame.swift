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
    var belowLuckyCards: [LuckyCard]
    var cardDealer: CardDealer
    
    init(){
        attendees = []
        belowLuckyCards = []
        cardDealer = CardDealer()
    }
    
    func gameStart(attendeeNum: AttendeeNum){
        let luckyCardPool:[LuckyCard] = cardDealer.makeCardPool(attendeeNum: attendeeNum)
        let luckyCardDecks: [Deck] = cardDealer.splitCard(attendeeNum: attendeeNum, cardPool: luckyCardPool)
        
        for i in 0..<(attendeeNum.rawValue){
            attendees.append(Attendee(deck: luckyCardDecks[i]))
        }
        
        belowLuckyCards = luckyCardDecks.last?.cards ?? []
    }
}
