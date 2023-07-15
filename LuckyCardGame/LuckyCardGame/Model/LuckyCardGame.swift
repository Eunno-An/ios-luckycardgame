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
    private(set) var temporaryChoicedCards: [TempChoicedCardInfo]
    private(set) var finalResult: FinalResult
    init(){
        attendees = []
        belowLuckyCards = []
        cardDealer = CardDealer()
        temporaryChoicedCards = []
        finalResult = FinalResult()
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
        
        finalResult = FinalResult(attendeeNum: attendeeNum)
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
    
    //MARK: temporaryChoicedCards에 새롭게 선택한 카드를 넣는 함수입니다.
    public func appendTemporaryChoicedCards(tempChoicedCardInfo: TempChoicedCardInfo){
        self.temporaryChoicedCards.append(tempChoicedCardInfo)
    }
    
    //MARK: temporaryChoicedCards의 사이즈가 세개인지 확인하는 함수입니다.
    public func checkThreeCardsInTemporaryChoiceCards() -> Bool{
        return temporaryChoicedCards.count == 3
    }
    
    //MARK: temporaryChoicedCards의 사이즈가 세개라면, 결과로 데이터를 보내주는 함수입니다. 그리고 temporaryChoiceCards를 비웁니다.
    public func sendCardsToFinalResults(){
        if temporaryChoicedCards.count == 3{
            for temporaryChoicedCard in temporaryChoicedCards{
                finalResult.addCardsToFinalResult(temporaryChoicedCard: temporaryChoicedCard)
                //temporaryChoicedCard에 있는 정보로 각각의 card배열을 초기화해줘야함
                if temporaryChoicedCard.isBottomCard == true{ // 바닥 카드일경우
                    if belowLuckyCards.count > temporaryChoicedCard.cardIdx{
                        belowLuckyCards.remove(at: temporaryChoicedCard.cardIdx)
                    }
                }
                else{//플레이어 카드일경우
                    attendees[temporaryChoicedCard.playerIdx].deleteXthCardInMyDeck(cardIdx: temporaryChoicedCard.cardIdx)
                }
                
            }
        }
        
    }
    
    //MARK: temporaryChoiceCards를 비워주는 함수입니다.
    public func flushTemporaryChoicedCards(){
        self.temporaryChoicedCards = []
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
    
    /*
     MARK: 선택에 실패했을 경우, 원래 상태로 되돌리는 함수입니다.
     attendee가 호출한 canChoiceThisCard()에서 false값을 반환하면 이 함수가 호출됩니다.
     */
    func rollBackBeforeGameState(){
        for choiceCard in temporaryChoicedCards{
            attendees[choiceCard.playerIdx].flipXthCardFlip(cardIdx: choiceCard.cardIdx)
        }
    }
    
    /*
     */
    
    func checkThreeNumbersInTemporaryChoicedCardsAreSameNumber() -> Bool{
        return temporaryChoicedCards[0].card.number == temporaryChoicedCards[1].card.number && temporaryChoicedCards[1].card.number == temporaryChoicedCards[2].card.number
    }
}
