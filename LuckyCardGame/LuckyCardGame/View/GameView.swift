//
//  GameView.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/07.
//

import Foundation
import UIKit

class GameView: UIView{
    private var luckyCardGame: LuckyCardGame
    init(luckyCardGame: LuckyCardGame){
        self.luckyCardGame = luckyCardGame
        super.init(frame: CGRect(x: (CGFloat(Constant.horizontalSpacing)),
                                 y : (Constant.topSpacing + Constant.topRectHeight + Constant.spacing),
                                 width: (CGFloat(Int(Constant.screenWidth)) - CGFloat(Constant.horizontalSpacing * 2)), height: (Constant.screenHeight) - (Constant.topSpacing + Constant.topRectHeight + Constant.spacing)))
        self.addSubview(getBottomBoardView())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //LuckyCardGame.belowLuckyCards가 담길 공간을 표시하는 bottomBoardView
    public func getBottomBoardView() -> RoundBoardView{
        let numOfAttendee: Int = luckyCardGame.getNumOfAttendee()
        let lastBoardWidth: CGFloat = Constant.screenWidth - Constant.horizontalSpacing * 2
        
        var yPos: CGFloat = 0
        var lastBoardHeight: CGFloat = 0
        
        if numOfAttendee == 5{
            yPos = 5 * (Board.height + Constant.spacing)
            lastBoardHeight = Board.height
        }
        else if numOfAttendee == 3 || numOfAttendee == 4{//참가자가 3명 또는 4명일 때
            yPos = 4 * (Board.height + Constant.spacing)
            lastBoardHeight = Board.height * 2
        }
        
        let view = RoundBoardView(frame: CGRect(
            x: 0, y: yPos, width: lastBoardWidth, height: lastBoardHeight
        ))
        
        view.backgroundColor = .systemGray
        
        return view
    }
}
