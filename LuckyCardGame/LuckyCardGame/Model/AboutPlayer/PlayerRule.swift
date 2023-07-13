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
    
    func canFlipLeftMostSideCard() -> Bool
    func canFlipSecondLeftMostSideCard() -> Bool
    func canFlipRightMostSideCard() -> Bool
    func canFlipSecnodRightMostSideCard() -> Bool
    func canFlipDownSideCard(card: LuckyCard) -> Bool
}
