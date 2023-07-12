//
//  TempResultByTurn.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/13.
//

import Foundation

struct TempSavedCardInfo{
    
    private(set) var cardIdx: Int // 카드 번호
    private(set) var isBottomCardOrPlayerCard: Bool // 바닥에서 온 카드인지, 플레이어에서 온 카드인지
    private(set) var playerIdx: Int // 플레이어의 인덱스
    
    init(cardIdx: Int, isBottomCardOrPlayerCard: Bool, playerIdx: Int){
        self.cardIdx = cardIdx
        self.isBottomCardOrPlayerCard = isBottomCardOrPlayerCard
        self.playerIdx = playerIdx
    }
    
}
