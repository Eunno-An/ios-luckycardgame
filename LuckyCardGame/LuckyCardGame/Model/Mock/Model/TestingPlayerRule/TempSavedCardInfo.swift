//
//  TempResultByTurn.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/13.
//

import Foundation

struct TempSavedCardInfo{
    
    private(set) var cardIdx: Int // 덱에서의 카드 인덱스
    private(set) var isBottomCard: Bool // 바닥에서 온 카드인지, 플레이어에서 온 카드인지
    private(set) var playerIdx: Int // 플레이어의 인덱스
    private(set) var card: LuckyCard // 카드
    
    init(cardIdx: Int, isBottomCardOrPlayerCard: Bool, playerIdx: Int, card: LuckyCard){
        self.cardIdx = cardIdx
        self.isBottomCard = isBottomCardOrPlayerCard
        self.playerIdx = playerIdx
        self.card = card
    }
    
}
