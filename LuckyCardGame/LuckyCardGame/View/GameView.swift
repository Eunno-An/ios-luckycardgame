//
//  GameView.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/07.
//

import Foundation
import UIKit

class GameView: UIView{
    private var bottomBoardView: BottomBoardView = {
        let yPos = 4 * (Board.height + Constant.spacing)
        let lastBoardWidth: CGFloat = Constant.screenWidth - Constant.horizontalSpacing * 2
        let lastBoardHeight = Board.height * 2
        
        let bottomBoard = BottomBoardView(frame: CGRect(
            x: 0, y: yPos, width: lastBoardWidth, height: lastBoardHeight
        ) )
        bottomBoard.backgroundColor = .systemGray
        return bottomBoard
    }()
    init(){
        super.init(frame: CGRect(x: (CGFloat(Constant.horizontalSpacing)),
                                 y : (Constant.topSpacing + Constant.topRectHeight + Constant.spacing),
                                 width: (CGFloat(Int(Constant.screenWidth)) - CGFloat(Constant.horizontalSpacing * 2)), height: (Constant.screenHeight) - (Constant.topSpacing + Constant.topRectHeight + Constant.spacing)))
        self.addSubview(bottomBoardView)
    }
    
    override init(frame: CGRect){
        super.init(frame: CGRect(x: (CGFloat(Constant.horizontalSpacing)),
                                 y : (Constant.topSpacing + Constant.topRectHeight + Constant.spacing),
                                 width: (CGFloat(Int(Constant.screenWidth)) - CGFloat(Constant.horizontalSpacing * 2)), height: (Constant.screenHeight) - (Constant.topSpacing + Constant.topRectHeight + Constant.spacing)))
        self.bottomBoardView.frame = frame
        self.addSubview(bottomBoardView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setBottomBoardViewFrame(frame: CGRect){
        self.bottomBoardView.frame = frame
    }
    
}
