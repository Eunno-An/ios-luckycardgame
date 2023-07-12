//
//  Mock.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/12.
//

import Foundation

/*
 MARK: 실제 LuckyCardGame와 가장 비슷하게 구현된 수준의 객체인 Mock class를 만들었습니다.
 */
class Mock: LuckyCardGame{
    
    //모든 숫자가 정확히 들어있는지 체크하는 함수
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
    
    //모든 심볼이 정확히 들어있는지 체크하는 함수
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
    
    //정렬이 잘 되는지 확인하는 함수
    public func sortCardArrayASCByCardNumber(cards: [LuckyCard]) -> Bool{
        let sortedCards: [LuckyCard] = cards.sorted{
            $0.number.rawValue < $1.number.rawValue
        }
        for cardIdx in 0..<sortedCards.count-1{
            if sortedCards[cardIdx].number.rawValue > sortedCards[cardIdx+1].number.rawValue{
                return false
            }
        }
        return true
    }
    
    //세개의 카드의 숫자가 똑같은게 주어진 덱에 있는지 확인하는 함수
    public func checkThreeNumbersAreInDeck(cards: [LuckyCard], attendeeNum: AttendeeNum) -> Bool{
        
        var numCountArr: [Int] = Array(repeating: 0, count: 12)
        
        for card in cards{
            numCountArr[card.number.rawValue] += 1
            if numCountArr[card.number.rawValue] == attendeeNum.rawValue{
                return true
            }
        }
        return false
    }
    
    //세개의 주어진 카드 숫자가 똑같은지 확인하는 함수
    public func checkThreeNumbersAreSame(card1: LuckyCard, card2: LuckyCard, card3: LuckyCard) -> Bool{
        return card1.number == card2.number && card2.number == card3.number
    }
    
}
