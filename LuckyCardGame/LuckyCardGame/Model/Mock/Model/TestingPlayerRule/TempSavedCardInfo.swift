//
//  TempResultByTurn.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/13.
//

import Foundation

struct TempSavedCardInfo{
    
    private(set) var cardIdx: Int // 덱에서의 카드 인덱스
    private(set) var isBottomCardOrPlayerCard: Bool // 바닥에서 온 카드인지, 플레이어에서 온 카드인지
    private(set) var playerIdx: Int // 플레이어의 인덱스
    private(set) var cardNum: CardNumber // 카드 번호
    private(set) var cardSymbol: Animal // 카드 동물
    
    init(cardIdx: Int, isBottomCardOrPlayerCard: Bool, playerIdx: Int, cardNum: CardNumber, cardSymbol: Animal){
        self.cardIdx = cardIdx
        self.isBottomCardOrPlayerCard = isBottomCardOrPlayerCard
        self.playerIdx = playerIdx
        self.cardNum = cardNum
        self.cardSymbol = cardSymbol
    }
    
}
