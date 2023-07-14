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
    
    func canFlipLeftMostSideCard(temporaryChoicedCards: [TempChoicedCardInfo]) -> Bool
    func canFlipSecondLeftMostSideCard(temporaryChoicedCards: [TempChoicedCardInfo]) -> Bool
    func canFlipRightMostSideCard(temporaryChoicedCards: [TempChoicedCardInfo]) -> Bool
    func canFlipSecnodRightMostSideCard(temporaryChoicedCards: [TempChoicedCardInfo]) -> Bool
    func canFlipDownSideCard(card: LuckyCard, temporaryChoicedCards: [TempChoicedCardInfo]) -> Bool
    func canChoiceThisCard(card: LuckyCard, temporaryChoicedCards: [TempChoicedCardInfo]) -> Bool // 카드를 뽑을 수 있는지 없는지 확인하는 함수입니다. 여태까지 뽑은 숫자가 없거나, 현재 뽑은 카드가 이전에 뽑았던 카드와 같으면 Bool입니다.
}
