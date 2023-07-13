//
//  LuckyCardGame.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/07.
//

import Foundation

// MARK: LuckyCardGame을 즐겨주셔서 감사합니다.
class LuckyCardGame{
    private(set) var attendees: [Attendee]
    private(set) var belowLuckyCards: [LuckyCard]
    private(set) var cardDealer: CardDealer
    
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
        belowLuckyCards = luckyCardDecks.last?.cards ?? []
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
    
    public func set_xth_AttendeeCardInfo(attendeeIdx: Int, deck: Deck){
        attendees[attendeeIdx].setDeck(deck: deck)
    }
    
    public func getLuckyCardPool() -> [LuckyCard]{
        var ret : [LuckyCard] = []
        for attendee in attendees{
            ret += attendee.deck.cards
        }
        ret += belowLuckyCards
        return ret
    }
    
    //MARK: 모든 숫자가 정확히 들어있는지 체크하는 함수입니다.
    public func checkAllNumbersInCards(attendeeNum: AttendeeNum) -> Bool {
        
        var numCountArr: [Int] = Array(repeating: 0, count: 12)
        
        for luckyCard in getLuckyCardPool(){
            numCountArr[luckyCard.number.rawValue-1] += 1
        }
        
        var answerNumCountArr: [Int] = []
        
        if attendeeNum == .three{
            answerNumCountArr = Array(repeating: attendeeNum.rawValue, count : 12)
            answerNumCountArr[answerNumCountArr.count-1] = 0
        } else {
            answerNumCountArr = Array(repeating: attendeeNum.rawValue, count: 12)
        }
        return answerNumCountArr == numCountArr
    }
    
    //MARK: 모든 심볼이 정확히 들어있는지 체크하는 함수입니다.
    public func checkAllSymbolsInCards(attendeeNum: AttendeeNum) -> Bool{
        
        var animalCountArr: [Int] = Array(repeating: 0, count: attendeeNum.rawValue)
        
        for luckyCard in getLuckyCardPool(){
            animalCountArr[Animal.getAnimalIdx(animal: luckyCard.animal)] += 1
        }
        
        var answerAnimalCountArr: [Int] = []
        
        if attendeeNum == .three{
            answerAnimalCountArr = Array(repeating: 11, count: attendeeNum.rawValue)
        }else{
            answerAnimalCountArr = Array(repeating: 12, count: attendeeNum.rawValue)
        }
        return answerAnimalCountArr == animalCountArr
    }
    
}
