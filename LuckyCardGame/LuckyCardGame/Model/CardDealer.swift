//
//  CardDealer.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/06.
//

import Foundation

/*
 MARK: 참가자 수 정보가 주어지면, 전체 카드 풀을 만들고 이를 분배하는 카드딜러 구조체
 일단 명수가 주어지면, 각각 해야하는 기능들을 만든다.
 */
struct CardDealer{
    
    init(){
        
    }
}
extension CardDealer{
    
    // MARK: 참석자 수를 받으면, 딜러가 카드 풀을 생성해주는 함수입니다.
    func makeCardPool(attendeeNum: AttendeeNum) -> [LuckyCard]{
        var cardPool : [LuckyCard] = []
        for animal in Animal.allCases{
            for number in CardNumber.allCases{
                if(attendeeNum.rawValue == 3 && number.rawValue == 12){
                    continue
                }
                cardPool.append(LuckyCard(number: number, animal: animal))
                
            }
        }
        return cardPool
    }
    
    // MARK: 참석자 수와 cardPool을 받으면, 참석자 수만큼 럭키카드 배열과, 마지막 바닥에 놔야하는 카드를 구분해주는 함수입니다.
    func splitCard(attendeeNum: AttendeeNum, cardPool: [LuckyCard]) -> [Deck]{
        //attendeeNum에 따라서 참가자들이 가질 럭키카드의 배열들과, 바닥에 둘 카드를 나눠줍니다.
        var luckyCard2dArr = [Deck]()
        var shuffledCardPool = cardPool.shuffled()
        
        if attendeeNum == .three{
            for i in stride(from:0, through: 16, by: 8){
                luckyCard2dArr.append(Deck(cards: Array(shuffledCardPool[i..<i+8])))
            }
            luckyCard2dArr.append(Deck(cards: Array(shuffledCardPool[24..<33])))
        }
        else if attendeeNum == .four{
            for i in stride(from:0, through: 21, by: 7){
                luckyCard2dArr.append(Deck(cards: Array(shuffledCardPool[i..<i+8])))
            }
            luckyCard2dArr.append(Deck(cards: Array(shuffledCardPool[28..<36])))
        }
        else if attendeeNum == .five{
            for i in stride(from:0, through: 24, by: 6){
                luckyCard2dArr.append(Deck(cards: Array(shuffledCardPool[i..<i+8])))
            }
            luckyCard2dArr.append(Deck(cards: Array(shuffledCardPool[30..<36])))
        }
        
        return luckyCard2dArr
    }
}
