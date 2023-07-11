//
//  LuckyCardGame.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/07.
//

import Foundation

// MARK: LuckyCardGame을 즐겨주셔서 감사합니다.
class LuckyCardGame{
    private var attendees: [Attendee]
    private var belowLuckyCards: [LuckyCard]
    private var cardDealer: CardDealer
    
    init(){
        attendees = []
        belowLuckyCards = []
        cardDealer = CardDealer()
    }
    
    public func gameStart(attendeeNum: AttendeeNum){
        var gameAttendees: [Attendee] = []
        let luckyCardPool:[LuckyCard] = cardDealer.makeCardPool(attendeeNum: attendeeNum)
        let luckyCardDecks: [Deck] = cardDealer.splitCard(attendeeNum: attendeeNum, cardPool: luckyCardPool)
        
        for i in 0..<(attendeeNum.rawValue){
            gameAttendees.append(Attendee(deck: luckyCardDecks[i]))
        }
        attendees = gameAttendees
        belowLuckyCards = luckyCardDecks.last?.getCards() ?? []
    }
    
    public func getNumOfAttendee() -> Int{
        return attendees.count
    }
    
    public func getBelowLuckyCards() -> [LuckyCard]{
        return self.belowLuckyCards
    }
    
    public func setBelowLuckyCards(belowLuckyCards: [LuckyCard]){
        self.belowLuckyCards = belowLuckyCards
    }
    
    public func sortBelowLuckyCards_by_CardNumber(){
        self.belowLuckyCards.sort{
            $0.number.rawValue < $1.number.rawValue
        }
    }
    
    public func getMyInfo() -> Attendee{
        return attendees[0]
    }
    
    public func get_xth_AttendeeInfo(attendeeIdx: Int) -> Attendee{
        return attendees[attendeeIdx]
    }
    
    public func getAttendeesInfo() -> [Attendee]{
        return attendees
    }
    
    public func set_xth_AttendeeCardInfo(attendeeIdx: Int, deck: Deck){
        attendees[attendeeIdx].setDeck(deck: deck)
    }
    
    public func getLuckyCardPool() -> [LuckyCard]{
        var ret : [LuckyCard] = []
        for attendee in attendees{
            ret += attendee.getDeck().getCards()
        }
        ret += belowLuckyCards
        return ret
    }
    
}
