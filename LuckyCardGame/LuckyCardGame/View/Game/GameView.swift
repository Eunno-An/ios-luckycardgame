//
//  GameView.swift
//  LuckyCardGame
//
//  Created by Eunno An on 2023/07/07.
//

import Foundation
import UIKit

class GameView: UIView{
    
    public var bottomBoardView: BottomBoardView = {
        let yPos = 4 * (Board.height + Constant.spacing)
        let lastBoardWidth: CGFloat = Constant.screenWidth - Constant.horizontalSpacing * 2
        let lastBoardHeight = Board.height * 2
        
        let bottomBoard = BottomBoardView(frame: CGRect(
            x: 0, y: yPos, width: lastBoardWidth, height: lastBoardHeight
        ) )
        bottomBoard.backgroundColor = .systemGray
        return bottomBoard
    }()
    
    public var playerBoardViews: [PlayerboardView] = {
        var views: [PlayerboardView] = []
        for i in 1...AttendeeNum.three.rawValue{
            views.append(PlayerboardView(frame:
                                            CGRect(x: 0,
                                                y:  Constant.spacing * CGFloat(i-1) + Board.height * CGFloat(i-1),
                                                   width: CGFloat(Constant.screenWidth) - CGFloat(Constant.horizontalSpacing * 2),
                                                   height: Board.height), name: Board.labels[i-1]))
        }
        return views
    }()
    
    init(){
        super.init(frame: CGRect(x: (CGFloat(Constant.horizontalSpacing)),
                                 y : (Constant.topSpacing + Constant.topRectHeight + Constant.spacing),
                                 width: (CGFloat(Int(Constant.screenWidth)) - CGFloat(Constant.horizontalSpacing * 2)), height: (Constant.screenHeight) - (Constant.topSpacing + Constant.topRectHeight + Constant.spacing)))
        self.addSubview(bottomBoardView)
        for playerBoardView in playerBoardViews{
            self.addSubview(playerBoardView)
        }
    }
    
    override init(frame: CGRect){
        super.init(frame: CGRect(x: (CGFloat(Constant.horizontalSpacing)),
                                 y : (Constant.topSpacing + Constant.topRectHeight + Constant.spacing),
                                 width: (CGFloat(Int(Constant.screenWidth)) - CGFloat(Constant.horizontalSpacing * 2)), height: (Constant.screenHeight) - (Constant.topSpacing + Constant.topRectHeight + Constant.spacing)))
        self.bottomBoardView.frame = frame
        self.addSubview(bottomBoardView)
        for playerBoardView in playerBoardViews{
            self.addSubview(playerBoardView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setBottomBoardViewFrame(frame: CGRect){
        self.bottomBoardView.frame = frame
    }
    
    /*
     playerBoardViews 프로퍼티를 다시 수정하고, addSubView를 다시 호출해주는 함수입니다.
     addSubView까지 호출하는게 정답인지는 모르겠지만, layoutIfNeeded로 리팩토링이 가능하다면 하고 싶습니다.
     */
    public func setOtherPlayerBoardViews(playerBoardViews: [PlayerboardView]){
        for i in 0..<self.playerBoardViews.count {
            self.playerBoardViews[i].removeFromSuperview()
        }
        self.playerBoardViews = playerBoardViews
        for i in 1..<playerBoardViews.count {
            self.addSubview(playerBoardViews[i])
        }
    }
    
    public func setMyPlayerBoardViews(myBoardView: PlayerboardView){
        self.playerBoardViews[0].removeFromSuperview()
        self.playerBoardViews[0] = myBoardView
        self.addSubview(self.playerBoardViews[0])
    }
}
