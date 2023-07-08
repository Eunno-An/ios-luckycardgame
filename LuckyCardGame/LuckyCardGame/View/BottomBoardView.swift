//
//  BottomBoardView.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/08.
//

import Foundation

// MARK: GameView 하단에 카드를 놓는 BottomBoardView입니다.
class BottomBoardView : RoundBoardView{
    
    init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
