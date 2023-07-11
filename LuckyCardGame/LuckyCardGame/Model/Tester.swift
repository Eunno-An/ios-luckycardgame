//
//  Tester.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/06.
//

import Foundation

// MARK: 클래스나 구조체의 인스턴스 정보를 확인하기 위한 대리자입니다.
enum Tester{
    
    static func printCardInfo(deck: Deck){
        var printString: String = ""
        for card in deck.getCards(){
            printString += "\(card.describe)"
            printString += ", "
        }
        if(printString.count >= 2){
            printString.removeLast(2) // 카드에 이상한 번호가 들어있거나, 이상한 심볼이 들어가있으면 cards배열이 비게되는데, 이를 막기위한 예외처리입니다.
            print(printString)
        }
    }
}

